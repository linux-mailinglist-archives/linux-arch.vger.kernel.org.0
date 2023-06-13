Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9F72EA6B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjFMSB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbjFMSB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 14:01:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB410F7
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 11:01:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977c8423dccso1409275866b.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686679284; x=1689271284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU2BO0gcHFt44DuEFTAO2c7xYdpyPStn/nzoWP1HBD4=;
        b=SnD/cIvkfzkqGRNok796WXoGsXUdU9sBvSlP3oy/xAInYIN4thPyu4Gkh5f25KIQzD
         kONlO2rVUq+fMN3sZJaQK2IkftDpIUDOGRzchL9XxMoJSKDvY59g1M/V2uLyrrOUsGdY
         oCqeB+EzF91QHL+M6667rJrDl8cXulO0Bycg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679284; x=1689271284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU2BO0gcHFt44DuEFTAO2c7xYdpyPStn/nzoWP1HBD4=;
        b=TnEmMU+NfdMcP5Y8e3ELbfHFDUV3/nrL+2in7N+oXWq1uY0k1AitJ+q2nS+QzRhl72
         +t/iK+BpWTiFrvB6xQ9VdUQG6b9cFrca4xQ3nwnuw7BPxJ8t8vGjO46y4DCsWYDPvGTd
         aF2O8sU9RjUhmdvfF9svyJZfV1RjT78yVlkXdoTP6TtTxs3rWC0QHHX+2oj57LV7xDe4
         VJdF6xmeKau79XAvla53jp0XKSgbXdcyTHiGx6CbbuPlliLjNdDzSmlFxjADZCziLG5M
         aSzYBydgmto5gTW/YBmS0ojlGIFmRLiF4IiZiYARwEGvukEvEqBEVIHV1xiJTMdCMqd0
         Ocag==
X-Gm-Message-State: AC+VfDzJ7Uu/QNFWhr+Sx3Z1b1WswS3vkn/qGpAXcbqa3XVVhoKCGRV2
        BymnsoJoO7hS54XvLNLuJ4kQ+yuuu8WjYw3bGW9jP4LM
X-Google-Smtp-Source: ACHHUZ5X7cw4k192Fo+BIX2SDun4eFM1o/aRclPRd/WDdhbNHxNrbIDPgb82ag6VV9ETaLFGsogg0A==
X-Received: by 2002:a17:907:7292:b0:977:cc28:d974 with SMTP id dt18-20020a170907729200b00977cc28d974mr14362741ejc.14.1686679283864;
        Tue, 13 Jun 2023 11:01:23 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090617d400b009745b0cb326sm6879485eje.109.2023.06.13.11.01.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:01:21 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-977c8423dccso1409262666b.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 11:01:19 -0700 (PDT)
X-Received: by 2002:a17:907:7d92:b0:969:9c0c:4c97 with SMTP id
 oz18-20020a1709077d9200b009699c0c4c97mr13719822ejc.1.1686679279617; Tue, 13
 Jun 2023 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 11:01:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-PfXhVb7Atk+G8SNjFSvqDWu37KPFR-ssuM-j_o93Kg@mail.gmail.com>
Message-ID: <CAHk-=wh-PfXhVb7Atk+G8SNjFSvqDWu37KPFR-ssuM-j_o93Kg@mail.gmail.com>
Subject: Re: [PATCH v9 11/42] x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        broonie@kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1189,7 +1189,17 @@ static inline pte_t ptep_get_and_clear_full(struct=
 mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long addr, pte_t *ptep)
>  {
> -       clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       /*
> +        * Avoid accidentally creating shadow stack PTEs
> +        * (Write=3D0,Dirty=3D1).  Use cmpxchg() to prevent races with
> +        * the hardware setting Dirty=3D1.
> +        */
> +       pte_t old_pte, new_pte;
> +
> +       old_pte =3D READ_ONCE(*ptep);
> +       do {
> +               new_pte =3D pte_wrprotect(old_pte);
> +       } while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(lon=
g *)&new_pte));
>  }

Thanks. Much nicer with this all being done just one way and no need
for ifdeffery on config options and runtime static branches.

                  Linus
