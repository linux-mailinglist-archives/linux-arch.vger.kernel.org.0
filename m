Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430476C1E0
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 03:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjHBBHa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHBBH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 21:07:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C51BCF
        for <linux-arch@vger.kernel.org>; Tue,  1 Aug 2023 18:07:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so8864470a12.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2023 18:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690938447; x=1691543247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXkdVovEwsRXfv+Dg7OQg7KZYMXc3NVjQ9UsNbCmbkM=;
        b=h2oAqqiZHA1I7+7KJ4qkiD6c+sb34x9IKFRrWiIgIKCjYGnQ9LY5YfGQeIXDkWDb7n
         gaC4QjEwJE9EC56qPqcn+iDm0F8zZ/suBTIWB7KirvXY9IApXagyXhHGhA16U9vBIiRf
         g4LVUfyHUdi2IVB2eTF2vDKxmPMNA7awbpXws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938447; x=1691543247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXkdVovEwsRXfv+Dg7OQg7KZYMXc3NVjQ9UsNbCmbkM=;
        b=luHiv4U2avD12gIf/+2I9SuNDO+irjdALsDsFqjC7ai9UrShIo8NIs1u0shR1fHSq+
         Vjk3zlNVyfXswyWjsCftZzBeW2qChW/eobQQdmmzVpDxCJ144KKqU6sVvZLJZSKAcz4N
         mbf7Hz4uYT+kdbR1P+qz1SDwWVnDAhAq3O9Gztqs/RsmxklCvJBthpJs7rgkCV6M72wt
         kfMJ7TNwDUqIYTO8S8BVxkaHW5OGTQMkC051fLNxTpPS3GPfSV3ThuSDQBz8Ppibveok
         IQ4wzIgz4kGpkAlAFZyl06zOQm6rMic3F3k0VLeYpvzN+g20/Jup0aVwEu5VpgPWkrB0
         rYjA==
X-Gm-Message-State: ABy/qLbuV8yv8yE5+lXqGUc7ke7BsnHR0SOtWks6dgkAH+kc1CtQ8DRA
        KAw2/5RT0l3Hp4pCeXa9DQ3JN6gHpsC6Eqo1iVgIs7oZ
X-Google-Smtp-Source: APBJJlE7Wq3XIHi3RYupKj3ZpEIVAkjQs41P27n53vzzTA3LS5ybT09cqShIFjNz/Fy9Peb3vK8wfw==
X-Received: by 2002:aa7:c589:0:b0:522:2f8c:8953 with SMTP id g9-20020aa7c589000000b005222f8c8953mr3369695edq.39.1690938446721;
        Tue, 01 Aug 2023 18:07:26 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7d50b000000b0051df67eaf62sm7714625edq.42.2023.08.01.18.07.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 18:07:26 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so8898761a12.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2023 18:07:25 -0700 (PDT)
X-Received: by 2002:aa7:df18:0:b0:522:289d:8dcd with SMTP id
 c24-20020aa7df18000000b00522289d8dcdmr3129466edy.35.1690938445668; Tue, 01
 Aug 2023 18:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
In-Reply-To: <20230801-bitwise-v1-1-799bec468dc4@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Aug 2023 18:07:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
Message-ID: <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
To:     ndesaulniers@google.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 1 Aug 2023 at 15:22, <ndesaulniers@google.com> wrote:
>
> Compiling big-endian targets with Clang produces the diagnostic:
>
> fs/namei.c:2173:13: warning: use of bitwise '|' with boolean operands
> [-Wbitwise-instead-of-logical]
> } while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constants)));

Gaah.

Yes, I think that 'has_zero()' should return the 'unsigned long' bits
on big-endian too, because I do think we always want the bit ops, and
turn it into a boolean only at the very end.

> It appears that when has_zero was introduced, two definitions were
> produced with different signatures (in particular different return types).

Big-endian was kind of a later addition, and while that file is called
"generic", it's really "little-endian has an easier time of this all,
but let's do the 'generic' file for the more complicated case".

Who ends up being affected by this? Powerpc does its own
word-at-a-time thing because the big-endian case is nasty and you can
do better with special instructions that they have.

Who else is even BE any more? Some old 32-bit arm setup?

I think the patch is fine, but I guess I'd like to know that people
who are affected actually don't see any code generation changes (or
possibly see improvements from not turning it into a bool until later)

            Linus
