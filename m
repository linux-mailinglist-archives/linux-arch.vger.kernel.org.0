Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4D28EA88
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgJOBzK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbgJOByk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 21:54:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DADC0613D9
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 14:07:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so359751pll.8
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=dR7lB2w8aCjI+7SL+gCWVnyWE0EcJqrEtve/Fbe7wCs=;
        b=B/MjJBqabR3kHP8fuBSvbUC1hpjUg/luJg1VJj+JARvr6cqZGaBRBHiO64T1qx5Rz7
         jUR16cnHImawwz9obH9+PQiNMrBTw11th2E5mmAmePsS/Jq8oWK/UrnHLPf2dMOUMrJz
         Rj5PceZQsnxljXjERM8WV5U0foTw7fXr2J0EApon+KYJiAPlqBouCxvl3tSndHbB9IB2
         RZ92Jp5l+sW62Ablfb58utH8lz8FqYU4TTVIAZbSvWJlJMdH7B7+6Weotzz0eekyB5cu
         el6K4FFvc3oekO0Y8Xt5arM6WYR4BGQYcfpUpoknPGHQAEUtj3vY7RqRXNf4x7iqDJrA
         3LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dR7lB2w8aCjI+7SL+gCWVnyWE0EcJqrEtve/Fbe7wCs=;
        b=M9N8uZ4sMKyzKnB66ItR9Ed+cqrQBiC39Qaktm5wJUe4Y2JfDykh6NzAy4jXPv97gp
         +F0gD2JFT8+WSVDkHYzl5urRGVstTGvhtg6ZrEs/OLs16vO9za3pY2AIwBw+oa2r9Tkf
         WGHyptLUjyoWuz67RTMNspF8lWswVBuTixj+nkYyVkiQ/7M70jRUaQaXrmTXfgIq5afE
         pGS+Vmd+6xx0LbB5r8/6uPigJHFg62LmlxXC/u7X5S53SQgHDbiDHPZ1RCaQLOMSTUyZ
         FTqignLUybmyw1IRfeHmE/oVIIC/+zdyrp+uEK0RGtNW7E4GxCq5PqUK2kzXf4+8lkqL
         /UVg==
X-Gm-Message-State: AOAM5325UcSlkNTR7Du0Rd4S2k7TiLP7IZV9DM6+0xszmnEGC6dy2gzy
        uZ5meu/6ELhzHZgwRlmfqBpLmQ==
X-Google-Smtp-Source: ABdhPJykDDF86fwzs6jHsxI1qVDwzTE5CSv91OmX/qxVA0fgG8du089mMPQ6hbvROZzrmDNYuE/fNw==
X-Received: by 2002:a17:90a:4e47:: with SMTP id t7mr1017421pjl.26.1602709655153;
        Wed, 14 Oct 2020 14:07:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:21fb:4af8:8865:6308? ([2601:646:c200:1ef2:21fb:4af8:8865:6308])
        by smtp.gmail.com with ESMTPSA id jy19sm501565pjb.9.2020.10.14.14.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 14:07:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
Date:   Wed, 14 Oct 2020 14:07:30 -0700
Message-Id: <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
References: <20201014195823.GC18196@zn.tnic>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
In-Reply-To: <20201014195823.GC18196@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org




> On Oct 14, 2020, at 12:58 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Wed, Oct 14, 2020 at 08:45:37AM -0700, Andy Lutomirski wrote:
>>> On Wed, Oct 14, 2020 at 1:33 AM Ankur Arora <ankur.a.arora@oracle.com> w=
rote:
>>>=20
>>> Define clear_page_uncached() as an alternative_call() to clear_page_nt()=

>>> if the CPU sets X86_FEATURE_NT_GOOD and fallback to clear_page() if it
>>> doesn't.
>>>=20
>>> Similarly define clear_page_uncached_flush() which provides an SFENCE
>>> if the CPU sets X86_FEATURE_NT_GOOD.
>>=20
>> As long as you keep "NT" or "MOVNTI" in the names and keep functions
>> in arch/x86, I think it's reasonable to expect that callers understand
>> that MOVNTI has bizarre memory ordering rules.  But once you give
>> something a generic name like "clear_page_uncached" and stick it in
>> generic code, I think the semantics should be more obvious.
>=20
> Why does it have to be a separate call? Why isn't it behind the
> clear_page() alternative machinery so that the proper function is
> selected at boot? IOW, why does a user of clear_page functionality need
> to know at all about an "uncached" variant?
>=20
>=20

I assume it=E2=80=99s for a little optimization of clearing more than one pa=
ge per SFENCE.

In any event, based on the benchmark data upthread, we only want to do NT cl=
ears when they=E2=80=99re rather large, so this shouldn=E2=80=99t be just an=
 alternative. I assume this is because a page or two will fit in cache and, f=
or most uses that allocate zeroed pages, we prefer cache-hot pages.  When cl=
earing 1G, on the other hand, cache-hot is impossible and we prefer the impr=
oved bandwidth and less cache trashing of NT clears.

Perhaps SFENCE is so fast that this is a silly optimization, though, and we d=
on=E2=80=99t lose anything measurable by SFENCEing once per page.=
