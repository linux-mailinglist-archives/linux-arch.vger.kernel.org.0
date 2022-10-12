Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F485FCA8B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJLSYR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJLSYP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 14:24:15 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD718B25
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 11:24:14 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-136b5dd6655so8563221fac.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf4Q6mDzkHYolnexbxAtn/OulhdrRZBn/s//1eNnWwg=;
        b=MbeVngOZRHdoMllqTr4IQcXLSoP5HSPH4ieXT+UiAMWOPHKMyuBGVLI4tobfVhYpD1
         I6gOpReKUcBJphu0tM4SusihsfwEb9xO+GAt/f7Ut9XGkjAfcjlG7uKD4P4WTaciyCQZ
         fOpKxBXfiyt1ebHN+vzAtzDc/Szljf1htXxWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf4Q6mDzkHYolnexbxAtn/OulhdrRZBn/s//1eNnWwg=;
        b=tPEH1UFga5qhKox+GqzhEIlaMUoDTd5MF+kfrWNR4+oLOqeaV+x4diKhli1uITSTJN
         72qX9eX1LSs++lqaiNepRI/xhoF7nZ7hQ4hMR7IO1wYr/biU1fJuduG25C5EkxMi1RnA
         HwJkz0mxWTdLbXJgT2gGSAJoqsjNGwXzDmwWNQ7p6AnWMGmWoT+D/c2IcEPJEunTFSwp
         +rOTIa4jurAHzXEbQotExoXHGkNeqgiqFXbmrtN8nXNtieP/PBVJQaPZz2wRRgQIWPVR
         6skAD6ismY+xmnDpNLIIhhEHWOjFSFsDfVd3cG+QzJDS2TKk36A9wkWRrXV5ZLHqiG9X
         8a3A==
X-Gm-Message-State: ACrzQf06By5Hc7MhHap/ijpXikzx2IpePzCaUu0m45/5dt5pVviOomZU
        8kZZVNi3TF3/bkmoZ0JkOTTBTraG5qe4YQ==
X-Google-Smtp-Source: AMsMyM5fNmrqi5fx6+vpqgCAhsorOmj3C4+CVPgPoYkxSKbg9xLTOxuSaYubth3KC56G2FlaQZgLHA==
X-Received: by 2002:a05:6870:525:b0:130:9e35:137a with SMTP id j37-20020a056870052500b001309e35137amr3101631oao.88.1665599053137;
        Wed, 12 Oct 2022 11:24:13 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id i10-20020a056808030a00b0035494c1202csm3203090oie.42.2022.10.12.11.24.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 11:24:12 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so12706598oop.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Oct 2022 11:24:12 -0700 (PDT)
X-Received: by 2002:a05:6830:4421:b0:661:8fdd:81e9 with SMTP id
 q33-20020a056830442100b006618fdd81e9mr9723555otv.69.1665599051939; Wed, 12
 Oct 2022 11:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221012144846.2963749-1-chenhuacai@loongson.cn>
In-Reply-To: <20221012144846.2963749-1-chenhuacai@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 11:23:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=62F=soverz1NT41B1_CMtaxnUZX+_qGQ3mbeQdjivg@mail.gmail.com>
Message-ID: <CAHk-=wj=62F=soverz1NT41B1_CMtaxnUZX+_qGQ3mbeQdjivg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch changes for v6.1
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 12, 2022 at 7:51 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.1

Grr.

This was rebased mere hours before the pull request.

Much (all?) of it has been in next - with different commit IDs, of
course, but the question remains why you have rebased it?

It just makes it much less convenient for me to check "was this in
next?" and is generally a *horrible* thing to do.

                       Linus
