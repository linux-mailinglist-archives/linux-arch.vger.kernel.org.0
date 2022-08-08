Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD19058CC38
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbiHHQif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiHHQib (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 12:38:31 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EE7165BE
        for <linux-arch@vger.kernel.org>; Mon,  8 Aug 2022 09:38:30 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-32868f43dd6so86729277b3.8
        for <linux-arch@vger.kernel.org>; Mon, 08 Aug 2022 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XquYmP+vX0zNQXcxrD0gfmPbv/22szoR0PAdjI6c6FQ=;
        b=RBd6EjHhe971WD13rB9QwkHAT4JUbLr8pEwdWhmPMPYpucCEhUe0Fdxu7UVnbr9qpP
         hZWuzatpB+IqP6uU510l0sQTdjybSMTSw0lHTUAtbi7VRxP2+VL05RnJSC9tm4F4F9bv
         03IZzjd3BMx5tcDns/TvMijdidvLv9/X2frigVbrc5lBTVZIT8xVWMui/Av+CCl2HQ+g
         QeAwQ4P2RQXrRRxSJ9VYRfWwU8zBUJvN0TSOG9Egg5vBxghw1SEtI2yzQD4i2Egfj5MJ
         HUwil0l04LL4/UtY+kLAu1nwLKCUhG43pHEAAs+sHgqewUIscMdcTdTZ4xxjKOjwkI6L
         2CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XquYmP+vX0zNQXcxrD0gfmPbv/22szoR0PAdjI6c6FQ=;
        b=REWtrosn+goExVrpsRC4IAXbDGlNmfA0cNhMO7B4p94nAaRP/KncBXNH70ObW886UI
         uUYiWW6R9Z03XByr1/yCDaAWER89+eMz7fKaqAkV3HN7r15BUQOJJ34e8TG01MEHCayg
         OdWFKPmHwupMXPrkw9nG49Nqv4RLwISVRp1gHsI4DAOt2sFF2Im4wr/8IGOAFfeuxlEA
         cZjyQA/DbaDZZqEVKETj9GeCPzt8rsN4HurCynHq+CzNlV3+/m93tDh2zcXxWuLmXz/f
         nxLfa/dkhtFbDq4aSQKYZWVZMvGlzDp50J50AzN4MFV7W6Tbo39/KsNrfLRNaDNzYDw3
         bNbQ==
X-Gm-Message-State: ACgBeo06zfgW5paFqrVScN0Err7uiKAbIj+zA47R47RHzYq3SKDMGIb1
        UYdcz1UAkvmfFzjguWJCUhzeHmXl/R7i1KowFeq50g==
X-Google-Smtp-Source: AA6agR7qwVhhNLdxkz/r+4OMSs/UhsdFghsuBlEsQGkMrD95nZ9mCd4coeYCE332Xk5fz/fL87h9vbS2cVX9CTEt9Jg=
X-Received: by 2002:a81:7586:0:b0:31f:658e:1ac7 with SMTP id
 q128-20020a817586000000b0031f658e1ac7mr19730600ywc.295.1659976709754; Mon, 08
 Aug 2022 09:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
In-Reply-To: <20220701142310.2188015-44-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 8 Aug 2022 18:37:52 +0200
Message-ID: <CAG_fn=UF0+0EAJLx=tW=RDoFxuY8qd=bHcH362-kxMhOhKVFmg@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 1, 2022 at 4:25 PM Alexander Potapenko <glider@google.com> wrote:
>
> Under certain circumstances initialization of `unsigned seq` and
> `struct inode *inode` passed into step_into() may be skipped.
> In particular, if the call to lookup_fast() in walk_component()
> returns NULL, and lookup_slow() returns a valid dentry, then the
> `seq` and `inode` will remain uninitialized until the call to
> step_into() (see [1] for more info).
>
> Right now step_into() does not use these uninitialized values,
> yet passing uninitialized values to functions is considered undefined
> behavior (see [2]). To fix that, we initialize `seq` and `inode` at
> definition.

Given that Al Viro has a patch series in flight to address the
problem, I am going to drop this patch from KMSAN v5 series.
