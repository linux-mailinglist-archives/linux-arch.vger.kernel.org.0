Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446D0678E3C
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 03:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAXC3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 21:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXC3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 21:29:47 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F67A25A
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 18:29:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so10403698pgp.10
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EL33MbyBAeFj7W1ec+AuUrU/yhgkc3rBnt2BlC4w5M=;
        b=j4Co2CjFtUbQlY3aCX8ZaGPTa3bq/5mD2naMb3jg8EmNIah3y15FrWh/iDBJe8/mav
         3GWNT5fYif/IJNrSpvSxdRPB9dMBK/9iicboI5JbqCfSgQY0gF4g4daxhY/KxiwUWkma
         800yWr6LlupKIQRude2UxapBJLr1Oy/TbVhBWjgE9zONONrVzCUlBdkanBr3/c92sf/u
         zuUZw6bo5UqX35TYTDMPbkee/FuRVqkvyXO3S/HUIrnFYK30bzFbuQVvr0jVsegOh86M
         qtB235Tds0eSjSpFc+nNCn6URsIfJRxl7yZxH15S1Aqi++IxUOjAItYI/sP8MAZONqVw
         spGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EL33MbyBAeFj7W1ec+AuUrU/yhgkc3rBnt2BlC4w5M=;
        b=mFlMRad2pELboIpejL6feWHqOMQD1BZaSWaBVJ4EvhTf75A3SksuOZoVDJ+2heK92P
         kn0839LH4pT9GqFyHzoVCob1jZPBaemw8iSSZ/ZBCgqdYXHlpaAPdtpYYa2Psaq5BSC/
         0AHZ2Y0HBk1qq9q4I+IWfmlxAsGp91JK7avDwIedmttsRTSV9W7ghLWO1hrvmVFDc7VS
         xiWMgC4eODo4Kkxhs6Q7yJp1wiCfeFNBsabR0MMm5uuioVDrfgejV2tw2ak3P82XVZTW
         Dc3TaAHGEeKsT18VtNzcBFg+CQBPfVdG0AQTzmy43PK15MIUtBQSKsoQVrTBIU+uvcrG
         s5JA==
X-Gm-Message-State: AFqh2kpZBrD9p1ZDbLhj9yiZIizaaoq7w1njU4OMpkZPPbTjz1Mzf3yt
        SjwHTKjCGq3qeqIBFys2tc8fI241N5k=
X-Google-Smtp-Source: AMrXdXsgWBdkF5aJcEXfGt3E1+MiooI3g5UFcMgOiKWWV2GlTsc9rdrcqnSd7HVwvPKPTbVy+5n6nw==
X-Received: by 2002:aa7:8bdd:0:b0:58d:be65:f781 with SMTP id s29-20020aa78bdd000000b0058dbe65f781mr27427114pfd.5.1674527385193;
        Mon, 23 Jan 2023 18:29:45 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id x12-20020aa793ac000000b005898fcb7c2bsm290307pff.170.2023.01.23.18.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 18:29:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Jan 2023 12:29:38 +1000
Message-Id: <CQ02EXZ5THB8.4S19LP5ZFUM9@bobo>
Cc:     "Andy Lutomirski" <luto@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 2/5] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Nadav Amit" <nadav.amit@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.13.0
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-3-npiggin@gmail.com>
 <ee3844c0-b342-edc6-77cf-4cdc78e30a18@gmail.com>
 <4d26df97-3725-182b-6312-fa5cd8e9f85d@gmail.com>
In-Reply-To: <4d26df97-3725-182b-6312-fa5cd8e9f85d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon Jan 23, 2023 at 6:02 PM AEST, Nadav Amit wrote:
>
>
> On 1/23/23 9:35 AM, Nadav Amit wrote:
> >> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmdrop(mm);
> >> +=C2=A0=C2=A0=C2=A0 } else {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * mmdrop_lazy_tlb mu=
st provide a full memory barrier, see the
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * membarrier comment=
 finish_task_switch which relies on this.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb();
> >> +=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0 }
> >=20
> > Considering the fact that mmdrop_lazy_tlb() replaced mmdrop() in variou=
s=20
> > locations in which smp_mb() was not required, this comment might be=20
> > confusing. IOW, for the cases in most cases where mmdrop_lazy_tlb()=20
> > replaced mmdrop(), this comment was irrelevant, and therefore it now=20
> > becomes confusing.
> >=20
> > I am not sure the include the smp_mb() here instead of "open-coding" it=
=20
> > helps.
> I think that I now understand why you do need the smp_mb() here, so=20
> ignore my comment.

For the moment it's basically a convenience thing so the caller does not
have to care what option is configured. Possibly we could weaken it and
do necessary barriers in callers if we consolidated to one option, but
I'd have to be convinced it'd be worthwhile, because it would still make
it deviate from mmdrop(), and we'd probably at least need a release
barrier to drop the reference.

Thanks,
Nick
