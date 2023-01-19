Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206D673069
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 05:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjASEhC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 23:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjASEgm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 23:36:42 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC970C57
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 20:33:17 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so592457pga.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 20:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1J7vuOigOymY1Zk38Z4JeTgNz+j/oREHGhmGUsHx/8=;
        b=WZDUjfOLPsSuFKt/G39tLSbM/WFTPs7WukHsli7BbMY9RzqZl6rMnrLDVXibgONhry
         djMp0q12Qm8cDRHYTlSDHiDDtOR2lrDlAybOJVmnJks/ZHqOQL9VXE2eBoJZAahlTbvs
         rusBqUT/CMizS3EaWLfbxmgu6Po0I2w05ZQAN4eqq3IbKLykiU/5zWkQSbb1p1hYj7TQ
         La8n5Z+SvnWryMnobOTU3UQV+wCiyvvyK2cdyGBxONGIULOFdREjZVVrqQLCFU1F3lsr
         n/QHvaimR4CBSjxB7TJuT5hwcRhRaBKXp2zrSJV6m4yE+KnjyNP/AYt80HWDtVt+zOB2
         fa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1J7vuOigOymY1Zk38Z4JeTgNz+j/oREHGhmGUsHx/8=;
        b=imE6NVg30NSoKvhavMDe6jNw8fxZm0ArIgYhufOLFrGFD2ysNYYas3jQ06buG5Zz45
         pypvgpBk8TWq2JhEk2Amw/z04P/XPSdEROHbaTYsa3qp/Xe7gY+sQcHDbZnBlzym395M
         aPOuLzt/TY2pxI2MfUmKy1OadE0C6NT//oDUtv2NXOY1dl+EE+sxg8U8qoXHXfpjimrG
         yiw0Fypd4M9ZrXDcn7hVcEtMNy2nNjbYVo8Im9yuJJGqgE1HxOECSWwq1jDU1pRV5uWW
         VEOboJRTioE7tf1kKRRddl0PLA/rGRZ8gt86cZsy2VzR/+LMV3X7Rqvm536SY84bnLMt
         pmxA==
X-Gm-Message-State: AFqh2kr7EREUyCSRfOOZeBRL05i0RRxVUrnE+NSw+p8v+bqv2TyqHpWJ
        IV2BPmZTrloCxU/JDbaYzlYTnmWn8j4=
X-Google-Smtp-Source: AMrXdXuKZidOPo/a2pzghQNLOHD10FYNqkFh/Sf6FufPl/1jnSobgpJ6H0O40d0XuF6uZUnDLidggw==
X-Received: by 2002:a05:6a20:7a83:b0:b8:eaee:54cc with SMTP id u3-20020a056a207a8300b000b8eaee54ccmr6174042pzh.54.1674102256049;
        Wed, 18 Jan 2023 20:24:16 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id a82-20020a621a55000000b00587c11bc925sm19655163pfa.168.2023.01.18.20.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 20:24:15 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 14:22:52 +1000
Message-Id: <CPVVOWQ6SE2S.NQ3R9R77MFKI@bobo>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 3/5] lazy tlb: shoot lazies, non-refcounting lazy tlb
 mm reference handling scheme
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Nadav Amit" <nadav.amit@gmail.com>
X-Mailer: aerc 0.13.0
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-4-npiggin@gmail.com>
 <5F3590B8-3F25-4EFB-BE3A-D32AAAC0B2F4@gmail.com>
In-Reply-To: <5F3590B8-3F25-4EFB-BE3A-D32AAAC0B2F4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu Jan 19, 2023 at 8:22 AM AEST, Nadav Amit wrote:
>
>
> > On Jan 18, 2023, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> wrote=
:
> >=20
> > +static void do_shoot_lazy_tlb(void *arg)
> > +{
> > +	struct mm_struct *mm =3D arg;
> > +
> > + 	if (current->active_mm =3D=3D mm) {
> > + 		WARN_ON_ONCE(current->mm);
> > + 		current->active_mm =3D &init_mm;
> > + 		switch_mm(mm, &init_mm, current);
> > + 	}
> > +}
>
> I might be out of touch - doesn=E2=80=99t a flush already take place when=
 we free
> the page-tables, at least on common cases on x86?
>
> IIUC exit_mmap() would free page-tables, and whenever page-tables are
> freed, on x86, we do shootdown regardless to whether the target CPU TLB s=
tate
> marks is_lazy. Then, flush_tlb_func() should call switch_mm_irqs_off() an=
d
> everything should be fine, no?
>
> [ I understand you care about powerpc, just wondering on the effect on x8=
6 ]

Now I come to think of it, Rik had done this for x86 a while back.

https://lore.kernel.org/all/20180728215357.3249-10-riel@surriel.com/

I didn't know about it when I wrote this, so I never dug into why it
didn't get merged. It might have missed the final __mmdrop races but
I'm not not sure, x86 lazy tlb mode is too complicated to know at a
glance. I would check with him though.

Thanks,
Nick
