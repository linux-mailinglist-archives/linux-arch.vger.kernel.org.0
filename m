Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D565229E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 15:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLTOcY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiLTObu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 09:31:50 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F219286
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2022 06:31:49 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-14455716674so15557948fac.7
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2022 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=aW5RhtAsBkNvIR682pacJYjMBchjsl6CBpgm1GNt+MoU0xR7oZIbXklJVEhSA5imlQ
         5u50ol+9QlNXecXRFfrW9BlWpiEgwr54V46RQJ7vPMFVZN8nUM7UL5cjfEyDNsEd6TlT
         I+s90R9sBzg5F4fXqzDg5UVxzzA1ZnYyjdfck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=lEl0h7fKNYVfsbZYhMyLOj1OtMdzgwf0hnYlWl+j7MKjH8hpdA2ls4E7oYn+6ZblaR
         8PDye9IJMSSLP0Pa1U6s/rjnAlhxq8U1RJBXUfl8LeflonXVeAm0ped3FHMICAYg6mzR
         uDppFc6gAlFLuzL/AghoG8tN88t5CVo1hY48hTbZwVdGsE/IwMYp8rro8kSFHsUAHUj9
         5TVd0rB08YUSS8zRUwdbDSaPAmxm3QrAl99FVIyIw0t648fODepxMHdyO1ntHGjDAvnn
         l06RvKrDMpWeBQedoX3X9fI4C2aOi8H4bWQNQKa9mqZWvE6GwulupUvCjznP7ddXwihr
         1QVQ==
X-Gm-Message-State: ANoB5pnU8JPuD4OrL5bojd+ljbMMjLRi1C+G6t7nqq7VbZAwKwRf0Jix
        1DgtpUfyo/WD95QLW8mkERDWWC73c4GZAHKQ
X-Google-Smtp-Source: AA0mqf6RrTMCtmBwb9F9Y3vptQeaqPMMubvGltH6COu9xVqV99by2/lFIsR9GFMutykhAND5FF+GkQ==
X-Received: by 2002:a05:6870:b015:b0:13b:d896:5b01 with SMTP id y21-20020a056870b01500b0013bd8965b01mr23279004oae.47.1671546708725;
        Tue, 20 Dec 2022 06:31:48 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id q7-20020a37f707000000b006cbc00db595sm8829095qkj.23.2022.12.20.06.31.46
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:31:47 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id x11so10991579qtv.13
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2022 06:31:46 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr8424356qtq.436.1671546695878; Tue, 20
 Dec 2022 06:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux> <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Dec 2022 08:31:19 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 20, 2022 at 5:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> >
> > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > "ptr" gets modified, and they are allowed to do "useful" optimization.
>
> In this I've copied the existing cmpxchg_double() code; I'll have to let
> the arch folks speak here, I've no clue.

It does sound like the right thing to do. I doubt it ends up making a
difference in practice, but yes, the asm doesn't have a memory
clobber, so the input/output types should be the right ones for the
compiler to not possibly do something odd and cache the part that it
doesn't see as being accessed.

              Linus
