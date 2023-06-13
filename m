Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE872EA62
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjFMR7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 13:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjFMR7I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 13:59:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409D10F7
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:59:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-970056276acso873955766b.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686679146; x=1689271146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8Y88yptodPeuMRnHzLyyoqql+qi0tUT2B3rKlKiInQ=;
        b=gJfuJuWGwzTahQhP6SWhrbswhYanOSZIHfq8cGSpgZBaO3kwizWtUG5ctcp9nrBJYL
         xkgK4N6g8yoRvrNVhtZd9AF79QMqvnE4eDaxStQTYgr8cZm3ryZpQw5jeNjiD4n3tWy/
         /Bsh516rx13mY7nrp+yZP0XiCksnfRlj067+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679146; x=1689271146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8Y88yptodPeuMRnHzLyyoqql+qi0tUT2B3rKlKiInQ=;
        b=aaIlzbXJtreoK+5Li5Pr8Bbe+aKN+lpSH4PWBS+tkSRmZXI3vO8qZchf1Snw9ANe+B
         FC6Mo6Y5oTuENjLa/ufNcTegVN4oNeIiLGJYWvlxALDXRMQLGd5orvdZGGnhWqoY1i+f
         jJlyj0w5e7+ryJDNRbd7Sh4o9BD/js59D7utGikiguTUZfoEWE5VNWRsaCVctMnZzO5r
         Z4E4anh1Jvvvd+Yp7spw5a52clpv4jyskP8SQQ538hFUsLBTDB3hnmqoY+umjNotnW41
         RlKN/CWBnVh0eU9DE3rQbG9r2spWig5aTrXJY1Adr+fkkVrTOyuNW7v/xL905ry88zy1
         ts+g==
X-Gm-Message-State: AC+VfDxI5e8fOUnxVMEXWoiC7dAwYyeslZfNgMHLTBosUBJTos6bzku5
        /sdaLB+2XG4mn87JLuiHGxFSJAHMMf/i0cCBz3twyZ6p
X-Google-Smtp-Source: ACHHUZ6mTFgzIb6zPDNnGlkHv0fWz4bg3tnhQ5ViIkYqKsIGdTM0mE/ZP2ac0GPE8ryapGjqK0SIug==
X-Received: by 2002:a17:907:9704:b0:978:337e:c41a with SMTP id jg4-20020a170907970400b00978337ec41amr11974121ejc.14.1686679145915;
        Tue, 13 Jun 2023 10:59:05 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709064a1700b00978723f594bsm6860253eju.101.2023.06.13.10.59.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:59:04 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so5768677f8f.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:59:03 -0700 (PDT)
X-Received: by 2002:adf:e546:0:b0:306:41d3:fcb9 with SMTP id
 z6-20020adfe546000000b0030641d3fcb9mr8013110wrm.27.1686679143465; Tue, 13 Jun
 2023 10:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 10:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Message-ID: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Subject: Re: [PATCH v9 10/42] x86/mm: Introduce _PAGE_SAVED_DIRTY
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

Small nit.

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> +static inline unsigned long mksaveddirty_shift(unsigned long v)
> +{
> +       unsigned long cond =3D !(v & (1 << _PAGE_BIT_RW));
> +
> +       v |=3D ((v >> _PAGE_BIT_DIRTY) & cond) << _PAGE_BIT_SAVED_DIRTY;
> +       v &=3D ~(cond << _PAGE_BIT_DIRTY);

I assume you checked that the compiler does the right thing here?

Because the above is kind of an odd way to do things, I feel.

You use boolean operators and then work with an "unsigned long" and
then shift things by hand. So you're kind of mixing two different
mental models.

To me, it would be more natural to do that 'cond' calculation as

        unsigned long cond =3D (~v >> _PAGE_BIT_RW) & 1;

and keep everything in the "bitops" domain.

I suspect - and hope - that the compiler is smart enough to turn that
boolean test into just the shift, but if that's the intent, why not
just write it with that in mind and not have that "both ways" model?

> +static inline unsigned long clear_saveddirty_shift(unsigned long v)
> +{
> +       unsigned long cond =3D !!(v & (1 << _PAGE_BIT_RW));

Same comment here.

             Linus
