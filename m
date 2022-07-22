Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172057E455
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiGVQ2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGVQ2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 12:28:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09C8C74A
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 09:28:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so6479920edc.4
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dd7o9NBeDh2R1TLf2E06wU4FmDlwMriYkeqayOgdQg=;
        b=On14FoAtGfENETFC+Oeapfn/2P5WZvzYW3nri40gW4AmLkhFI+Cx/SgaB/M64Vy4wy
         W4wkNi66d0EKN6lqu/ILa3UGQXa8rAutUOe6riL92TMQsyUEWWDr5XsdVklQqrlBgEPx
         bk0UWslW/CblGSDaXd5DJQYCqFUGG+0bXu+hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dd7o9NBeDh2R1TLf2E06wU4FmDlwMriYkeqayOgdQg=;
        b=3XtPhHgJ/tWa8lcdT5Pj2/cQWLjIVsCuhsPmXuk/RabEssAWowrz7mGx/Y3A+k8bIS
         R0bhw+kW4gRqEfr38TrWwJnVxsvOcz0nNlrRtQDDNAwH6+lSwbhKBudqKzAt1ZB45jiL
         FqatiEsmZZmjYPmKHqVyM/tWASWFYE0P6HxV0WTbc69HBQKbaBAuJ5XzH1W/DkrcmrVU
         EuRx6kmLFMNzpy2w0a4owZ/oGfpHTDC/xgpEHPAMrglaVCr5PQ97lGnSmkMnzp4thGio
         ZZGrNR/HNCt6DOHIbPmFZ0nau9pslpYAqJ0vI6G837aF5piMnBNAjid0LdaUColEOjku
         4+tA==
X-Gm-Message-State: AJIora/Bd3+gkcS7BWF+ZvlxOL0pZyHpAAJpau2h3UxXWrqbcsP1/YWM
        Jc3+9KO/lii7345BIDnKUHRK+owpCk7+0kG9FI4=
X-Google-Smtp-Source: AGRyM1sIEBVRpeBfxEoxRPgsPE+ElJRvIoHah0RUP9YFVQTq/WlyD3JseuwDCsxGB28/A2WOv4MdeA==
X-Received: by 2002:a05:6402:4252:b0:43a:9232:dafc with SMTP id g18-20020a056402425200b0043a9232dafcmr651902edb.243.1658507294395;
        Fri, 22 Jul 2022 09:28:14 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0072f07213509sm2209659eju.12.2022.07.22.09.28.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:28:12 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bu1so7187830wrb.9
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 09:28:11 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr468958wrb.442.1658507291147; Fri, 22
 Jul 2022 09:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <YtpXh0QHWwaEWVAY@debian>
In-Reply-To: <YtpXh0QHWwaEWVAY@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jul 2022 09:27:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
Message-ID: <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
Subject: Re: mainline build failure due to b67fbebd4cf9 ("mmu_gather: Force
 tlb-flush VM_PFNMAP vmas")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f26f5605e4675143"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--000000000000f26f5605e4675143
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 22, 2022 at 12:53 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> The latest mainline kernel branch fails to build for alpha allmodconfig
> with the error:

Gaah. It's the odd MMU_GATHER_NO_RANGE architectures - alpha, m68k,
microblaze, nios2 and openrisc.

We should probably get rid of that oddity, and force everybody to have
the ranged tlb flush functions, but for now the trivial patch is to
just remove the left-over dummy tlb_update_vma_flags() from that case,
I think.

Trivial patch attached. I don't have any cross-compiler for those
architectures on my machine, but I suspect I'll just commit it as-is
even without testing, since it can't be worse than what the situation
is right now with that "redefinition of 'tlb_update_vma_flags'"

But if you can verify, that would be lovely.

                    Linus

--000000000000f26f5605e4675143
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l5woep5b0>
X-Attachment-Id: f_l5woep5b0

IGluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmggfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaCBiL2luY2x1
ZGUvYXNtLWdlbmVyaWMvdGxiLmgKaW5kZXggY2IyMTY3Yzg5ZWVlLi40OTJkY2U0MzIzNmUgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgKKysrIGIvaW5jbHVkZS9hc20tZ2Vu
ZXJpYy90bGIuaApAQCAtMzY4LDkgKzM2OCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0bGJfZmx1
c2goc3RydWN0IG1tdV9nYXRoZXIgKnRsYikKIAkJZmx1c2hfdGxiX21tKHRsYi0+bW0pOwogfQog
Ci1zdGF0aWMgaW5saW5lIHZvaWQKLXRsYl91cGRhdGVfdm1hX2ZsYWdzKHN0cnVjdCBtbXVfZ2F0
aGVyICp0bGIsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKSB7IH0KLQogI2Vsc2UgLyogQ09O
RklHX01NVV9HQVRIRVJfTk9fUkFOR0UgKi8KIAogI2lmbmRlZiB0bGJfZmx1c2gK
--000000000000f26f5605e4675143--
