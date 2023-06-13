Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59572EB13
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFMSgV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjFMSgT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 14:36:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4D419B7
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 11:36:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e83d536fso824523966b.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686681377; x=1689273377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c13OqGThZo2X78u4bO5FLqEGNspfbVSXUjccgWtSHTY=;
        b=LwkOewgXfzdXx457Xyw1au6p7f8dbgn/FkzvTCEA2NP1UOfCB31S9X5bUaBgpecAe3
         q1UGbotBNOgN757jtcMbGw/TTSoclC32s7vbOdl+2SgP7riTgo67SKV6FnH4RsI3BWLw
         JCFIvEx+QgChHnUlPmRbPNMZi3+KqGKNe96Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681377; x=1689273377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c13OqGThZo2X78u4bO5FLqEGNspfbVSXUjccgWtSHTY=;
        b=FXWH7/jQkjIq0eLGHOlwJjxqlEcx8rZkUfG5bF88TxqxQhrU4KtHh74Zz3h437rrd0
         4ttSlFejvU5/SoyoDST66Z7soZyZpZ6iEkxclAVGCf7ADHz/hUeAzxwjxzclu2z85kUd
         6rAUmmQGplPHfkaJ8F0dydg09KZLXClm0tAkdl8A6za1b2lm1i0qIwq1SThPDnwRn4kp
         DQ+z+lmc8/C5sBic082juiRV/znXMSu8T3CF/ZMhJO+oTT4q0R6vniwp37QWKlsEwxDz
         DW9KyCqxBsLPkUZkQZk+urotpxifH+wCgat32dlrAYOtn0jtdHZMya5dgp8eUFxNRt5V
         ENTQ==
X-Gm-Message-State: AC+VfDy+wRv7UPhc1QvrwzGOZBzvN9Pl5ehGKDnBDPuklzki6mRcBUKc
        fPbqW8qObyAj6KpAEULju4vTPdGcjVmtFPPJBP9+KKjD
X-Google-Smtp-Source: ACHHUZ7n1yEPIRogC91TNg8VYkv4njubraF1ZegcyY6g/qnzW2rn4cULiIFnp9mshtNauQCMkmRY1Q==
X-Received: by 2002:a17:907:74a:b0:978:af67:c7f6 with SMTP id xc10-20020a170907074a00b00978af67c7f6mr12315871ejb.13.1686681376946;
        Tue, 13 Jun 2023 11:36:16 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090627d700b009787b13d1ddsm7014236ejc.51.2023.06.13.11.36.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:36:16 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso8816821a12.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 11:36:16 -0700 (PDT)
X-Received: by 2002:a19:3819:0:b0:4f7:457e:a457 with SMTP id
 f25-20020a193819000000b004f7457ea457mr3476722lfa.53.1686680882933; Tue, 13
 Jun 2023 11:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
 <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com> <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 11:27:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com>
Message-ID: <CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
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

On Tue, Jun 13, 2023 at 10:44=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, I'm scanning through it right now. No comments yet, I only
> just got started.

Well, it all looked fine from a quick scan. One small comment, and
even that was just a minor stylistic nit.

I didn't actually look through the x86 state infrastructure side -
I'll just trust that is fine, and it doesn't interact with anything
else, so I don't really worry about it. I mainly care about the VM
side not causing problems, and the changes on that side all looked
fine.

             Linus
