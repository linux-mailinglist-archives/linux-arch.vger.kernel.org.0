Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6E5F354F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJCSLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJCSLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:11:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB72D773;
        Mon,  3 Oct 2022 11:11:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso4362093pjf.2;
        Mon, 03 Oct 2022 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=en10y39vDLTnejuV4gccDi3qHezynQM0qaTlbvxlVLQ=;
        b=HKIIYt4XvLJ1WSWh7wT6oSZNazuETj1fKfDiouYZYQF9GHB0d8RkN9tT2SOSginMRx
         mHuC/sOjMt9vjIsjPAWYIui2X1OwgRKArHx610SVVVktWSoXiCvLTE96TRao0m8S6+XO
         9HCS9MTCkhdCerBdfVo3K9cEQivoThb0ez6+rP5fNNSq9BL9j8a8m9EhIPXBwLs7A31t
         VqpjkNo96iZW5/5j0oHyUCNMEAjjo2392noriLN0irVIZgdTq7SGoQR+8EQL7kFNCHH8
         nesgvL0FkW4VHYThGCO64cU2dPDWIPcWGEyg5Xf64+GEx51+K2XLwge6RhFvcRJTj5Yy
         Vt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=en10y39vDLTnejuV4gccDi3qHezynQM0qaTlbvxlVLQ=;
        b=zMdTI31ZROtXTaZh6XKVZtS/UuM7xfZ/NISutX3Qmpxp3S7k6pbpIwLeVgXX2xTSnD
         2G7P4jXJCzaLIIAKxZvZ2nkPk0TU0sFQN9s7QVaNVdv5VcZlcdox+D8ZuF99LqX+lGmg
         gpASBqkGhkBciyeLyY0YPRXAl9/YIS471XmnvRqTEVRMj9tGM3LxmofN9LZYpKaorOcN
         tyl+nweUKMFmOh4Qt04rSnTvfSwhEuYhYOPpSF90mOZ9p8fvVSo2WEBzlOKOd/TpVqEk
         dfmQWlmIJ70+q3ypXV8Kb09cAd5Pqt7qkhYdhuxl7GglhSuwMjEVa96xX2c6vyIej2Kl
         A5ew==
X-Gm-Message-State: ACrzQf2uphtoZWa4CCRxd8umziUUcopOvsR+LEfnToRViFt1X5sCjfDW
        4zDAVSyKgYhYM/Ok+4QDetk=
X-Google-Smtp-Source: AMsMyM4pbEL9xsk99Si+J4HSD+flvT5y3HUKNRrdeLEplExgmawzwe48C/a+pLfmYGejOuIUvKIrug==
X-Received: by 2002:a17:902:da8b:b0:178:3980:4597 with SMTP id j11-20020a170902da8b00b0017839804597mr24037953plx.113.1664820697509;
        Mon, 03 Oct 2022 11:11:37 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001745662d568sm7615527pla.278.2022.10.03.11.11.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 11:11:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220929222936.14584-13-rick.p.edgecombe@intel.com>
Date:   Mon, 3 Oct 2022 11:11:33 -0700
Cc:     X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Mike Rapoport <rppt@kernel.org>, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sep 29, 2022, at 3:29 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> =
wrote:

> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>=20
> When Shadow Stack is in use, Write=3D0,Dirty=3D1 PTE are reserved for =
shadow
> stack. Copy-on-write PTes then have Write=3D0,Cow=3D1.
>=20
> When a PTE goes from Write=3D1,Dirty=3D1 to Write=3D0,Cow=3D1, it =
could
> become a transient shadow stack PTE in two cases:
>=20
> The first case is that some processors can start a write but end up =
seeing
> a Write=3D0 PTE by the time they get to the Dirty bit, creating a =
transient
> shadow stack PTE. However, this will not occur on processors =
supporting
> Shadow Stack, and a TLB flush is not necessary.
>=20
> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW =
non-
> atomically, a transient shadow stack PTE can be created as a result.
> Thus, prevent that with cmpxchg.
>=20
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided =
many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
>=20
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>=20
> ---
>=20
> v2:
> - Compile out some code due to clang build error
> - Clarify commit log (dhansen)
> - Normalize PTE bit descriptions between patches (dhansen)
> - Update comment with text from (dhansen)
>=20
> Yu-cheng v30:
> - Replace (pmdval_t) cast with CONFIG_PGTABLE_LEVELES > 2 (Borislav =
Petkov).
>=20
> arch/x86/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/pgtable.h =
b/arch/x86/include/asm/pgtable.h
> index 2f2963429f48..58c7bf9d7392 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1287,6 +1287,23 @@ static inline pte_t =
ptep_get_and_clear_full(struct mm_struct *mm,
> static inline void ptep_set_wrprotect(struct mm_struct *mm,
> 				      unsigned long addr, pte_t *ptep)
> {
> +#ifdef CONFIG_X86_SHADOW_STACK
> +	/*
> +	 * Avoid accidentally creating shadow stack PTEs
> +	 * (Write=3D0,Dirty=3D1).  Use cmpxchg() to prevent races with
> +	 * the hardware setting Dirty=3D1.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pte_t old_pte, new_pte;
> +
> +		old_pte =3D READ_ONCE(*ptep);
> +		do {
> +			new_pte =3D pte_wrprotect(old_pte);
> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, =
new_pte.pte));
> +
> +		return;
> +	}
> +#endif

There is no way of using IS_ENABLED() here instead of these ifdefs?

Did you have a look at ptep_set_access_flags() and friends and checked =
they
do not need to be changed too? Perhaps you should at least add some
assertion just to ensure nothing breaks.

