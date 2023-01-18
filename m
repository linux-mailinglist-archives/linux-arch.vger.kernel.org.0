Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD3672B38
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 23:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjARWWW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 17:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjARWWV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 17:22:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C825D7EB
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 14:22:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so2703862pjb.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0ldSOk59OSUgQEm352Q1IAMDrBH9zEdmVsSi4rhzHs=;
        b=d2qNB+Xf95ts7qkj9ZiaPnBajtLu/iVQiBTSgC7UnMvkJQfDG3lM4n6iSmLIyl4v3s
         3rmfStEJ3hoCz/N6NCboYVr8sGHYbUaDBZ3riuhEADQvr4DF2XEVHeWld8Td+GJ5fmjE
         EVyonHor1Yeb/PODxfsRmDbI1c3LrbUxKulzi1mF8cBSG67LMY3hCTMFiwdjHpWfJK2d
         shgzG2mHfNhl/hyynoWMxuolQGRmbCAJDNJTHOL4tRjYe6lN8vDWeKVoJyb7gns8eUTM
         cwDr4PdGMWl+hDydjkIigOM2lQ3ewGntx3K0JC4HnXQdlZNDHs32qYzhlq/8roY3Snpe
         mQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0ldSOk59OSUgQEm352Q1IAMDrBH9zEdmVsSi4rhzHs=;
        b=WuDulQGou95molob33BC+lswI5IWafa7zBn8+Lh2hS+riE+6HhXzzX7DiNdWK+NoAt
         IRkDtG7wj1S53oyYOiB0MksR+x4XDCvFIjukbaBwNM/9U+MxQOxCfb103E2358HoC+V7
         olji0eZGtY2dadzPPc5V90GzjDWqwauGDGHHKBnvqM9gC28l8WGVPvkrlijgk1N5bGv9
         +7V5w7vSvBBjHaaNzXkYf2yQ1DjD7D0M5gLm9dZdKy+uRoKRQX0dcbDBYFKy+RbQz4SH
         /rwjRJYG9Hi5sOeNlqJ/9FTIVWM9j7phhYCGrTR18wFUcSP0BfHYRAIvfSSyyh8s413E
         XW+w==
X-Gm-Message-State: AFqh2kr/gplc7naFU4mWXllkls1fr8VyiSByCwn7ozYvtlI8BX7eNsxP
        RrNIWtqHurm6PdiFyBAULV9R2amPoeJFyUFV
X-Google-Smtp-Source: AMrXdXvRavXFFRYE14blzdZLuVmL27/NTESzDN8xeMK+lNpE66Enb5Ky51V+R/46yv36y/vDYHNI+A==
X-Received: by 2002:a17:90b:368f:b0:229:1607:c830 with SMTP id mj15-20020a17090b368f00b002291607c830mr9173236pjb.25.1674080539376;
        Wed, 18 Jan 2023 14:22:19 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id dw13-20020a17090b094d00b00226f49eca92sm1840043pjb.28.2023.01.18.14.22.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 14:22:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v6 3/5] lazy tlb: shoot lazies, non-refcounting lazy tlb
 mm reference handling scheme
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230118080011.2258375-4-npiggin@gmail.com>
Date:   Wed, 18 Jan 2023 14:22:07 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F3590B8-3F25-4EFB-BE3A-D32AAAC0B2F4@gmail.com>
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-4-npiggin@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 18, 2023, at 12:00 AM, Nicholas Piggin <npiggin@gmail.com> =
wrote:
>=20
> +static void do_shoot_lazy_tlb(void *arg)
> +{
> +	struct mm_struct *mm =3D arg;
> +
> + 	if (current->active_mm =3D=3D mm) {
> + 		WARN_ON_ONCE(current->mm);
> + 		current->active_mm =3D &init_mm;
> + 		switch_mm(mm, &init_mm, current);
> + 	}
> +}

I might be out of touch - doesn=E2=80=99t a flush already take place =
when we free
the page-tables, at least on common cases on x86?

IIUC exit_mmap() would free page-tables, and whenever page-tables are
freed, on x86, we do shootdown regardless to whether the target CPU TLB =
state
marks is_lazy. Then, flush_tlb_func() should call switch_mm_irqs_off() =
and
everything should be fine, no?

[ I understand you care about powerpc, just wondering on the effect on =
x86 ]

