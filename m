Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B33621D62
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKHUDx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 15:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKHUDv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 15:03:51 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769B920F7C
        for <linux-arch@vger.kernel.org>; Tue,  8 Nov 2022 12:03:49 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id lf15so10528895qvb.9
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2022 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL0asLvlwl9giKA9UGTHJNcZfeM0NFLRZL9VMviIdpQ=;
        b=IOKkCDTIpUpxSMaRhG1HFNbcwYu+PEBJ+mUJ8Wr4Y3q9YzVktrJ0Ro6T06x6yTcVRo
         /oaNbicnQNvOi+BcBQbkylbpBU2WS5TRf1OC+Gh5E7PEqm0JAj5fmW5FUn2Q+s7VT4iF
         c2BMZ1ahH6YGuUTO6PW8yxp6BKdcQoorRbGm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL0asLvlwl9giKA9UGTHJNcZfeM0NFLRZL9VMviIdpQ=;
        b=5MLkwiu7gxTCHUhLwjnc52CwS+iS+4BMXMRw9VB+HaLdDhYEMh2B2k05fdW4tz03Sy
         mx/PcpgMU8ksmaOvbBHcFuwgO2YYGNhfpDAgaeqDA0oWJejbPsH0cjUbPBNr8VYrA8Pj
         FjqcdHBnUVNNWDZJhD8kBZsshZjwoWGtqK5Kp3/q9ZkP36NEucMqr3+ELE0A184g4a4h
         TX2ssevlLdhNwwx3S9h3hbQCudPGTAqHvSBfDFJHJSt4ZgEukIKsh/iPTc9jhMLHnwE8
         k5W3l22cQ0/7z+mnCTpULigHyqRE4ojdxzCa+rleEHb8C8aWPSTazksPq7x3TRZT/z2G
         mcog==
X-Gm-Message-State: ACrzQf1vS9gtyjc33MM8vi2l+afjp8pmh093EWgfCmdDm64bHnHtVYz2
        KEGvJuuLP7h1C3aEn/WMeP776g==
X-Google-Smtp-Source: AMsMyM6rEDtWEBWAQcaTFfwCNgKArFwSlYHL/s0WwHcHNkYUSaH5x6Z0HBtzbns4+gyUTJ4h8ARXpg==
X-Received: by 2002:ad4:5dc6:0:b0:4bb:798f:5272 with SMTP id m6-20020ad45dc6000000b004bb798f5272mr51061523qvh.131.1667937828083;
        Tue, 08 Nov 2022 12:03:48 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id t19-20020a05620a451300b006ce2c3c48ebsm10087338qkp.77.2022.11.08.12.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:03:47 -0800 (PST)
Sender: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Tue, 8 Nov 2022 15:03:45 -0500
From:   Konstantin Ryabitsev <mricon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: mm: delay rmap removal until after TLB flush
Message-ID: <20221108200345.xxcvnsnwgjyb7w3a@meerkat.local>
References: <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
 <Y2llcRiDLHc2kg/N@cmpxchg.org>
 <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
 <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <CAHk-=whi2BB9FviYiuUWV0KHibP_Lx_CWDWkxxv3SXA1PKV0Lg@mail.gmail.com>
 <CAHk-=wivgyfywteXoO7K0Mj_KoCRF-RyXDH-eGW0A_fev+dGug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wivgyfywteXoO7K0Mj_KoCRF-RyXDH-eGW0A_fev+dGug@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 08, 2022 at 11:56:13AM -0800, Linus Torvalds wrote:
> On Mon, Nov 7, 2022 at 8:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'm sending this out because I'm stepping away from the keyboard,
> > because that whole "let's massage it into something legible" was
> > really somewhat exhausting. You don't see all the small side turns it
> > took only to go "that's ugly, let's try again" ;)
> 
> Ok, I actually sent the individual patches with 'git-send-email',
> although I only sent them to the mailing list and to people that were
> mentioned in the commit descriptions.
> 
> I hope that makes review easier.
> 
> See
> 
>    https://lore.kernel.org/all/20221108194139.57604-1-torvalds@linux-foundation.org
> 
> for the series if you weren't mentioned and are interested.
> 
> Oh, and because I decided to just use the email in this thread as the
> reference and cover letter, it turns out that this all confuses 'b4',
> because it actually walks up the whole thread all the way to the
> original 13-patch series by PeterZ that started this whole discussion.
> 
> I've seen that before with other peoples patch series, but now that it
> happened to my own, I'm cc'ing Konstantine here too to see if there's
> some magic for b4 to say "look, I pointed you to a msg-id that is
> clearly a new series, don't walk all the way up and then take patches
> from a completely different one.

Yes, --no-parent.

It's slightly more complicated in your case because the patches aren't
threaded to the first patch/cover letter, but you can choose an arbitrary
msgid upthread and tell b4 to ignore anything that came before it. E.g.:

b4 am -o/tmp --no-parent 20221108194139.57604-1-torvalds@linux-foundation.org

-K
