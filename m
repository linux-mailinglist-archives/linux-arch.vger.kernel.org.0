Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83716EE83A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Apr 2023 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjDYT2D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Apr 2023 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjDYT2B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Apr 2023 15:28:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31332269E
        for <linux-arch@vger.kernel.org>; Tue, 25 Apr 2023 12:27:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9536df4b907so1153784666b.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Apr 2023 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682450859; x=1685042859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiAll7RfuduP0I53YTER9ohVBuZInpNAgveNMxgNuT8=;
        b=eikwr/vjGm0/7viBcsrJMjWqPjw51ykPahnc3BBTgRc3WG4WxE3HpbmooFpsLb2ifk
         qVLu0pRFZfoNs2LGxNXGUBhPW7q8f6BcPBGxskWk5uruNIzkFgcVrzgWcVJfzkRaKTPd
         N6f0beUvTDuTUCMp3W2nkeHOlkuDZ5N0/gRjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450859; x=1685042859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiAll7RfuduP0I53YTER9ohVBuZInpNAgveNMxgNuT8=;
        b=T7UBVrJBSS71JxzAsPbqdEil4n0rpV3ieOWczVeefNagolCJVQqQvgItbDuczpJbR4
         PdciR5hkJ3kY2DZxtyYyprvdp7ZCTEKcPu4QjXV2wu20ei9p8tYsC5BNl/xuPM8U7hf7
         MbM/wgNMAamEICLPrjt0kzAPgpITuGkPB6u44Q2zI2KtxJIV1RCuTN6OERF07U/UMOGS
         LjBkTxSKuLJ+AiNQTIxMaW3152jR0cGYiZCQAoBCU/xD/7abXZP4+IGksBDkR0zFKIZ9
         uVxXVwBOANgS30LFT4r/LTorcwrJ0IlP5Wmx5/ykaioV97a6wjbpoDnEerjFQD4wPlN9
         NQcw==
X-Gm-Message-State: AAQBX9cCUZ8VQ2Ok6VLcLK6H5NUnyul5pfyottoLV+kg0VSRtuWvoYll
        sQcjAmFQ5DUu5HwsCOPECQnfnlMm9UZpNlito+KZYQ==
X-Google-Smtp-Source: AKy350ZKk+StBS/HmTkmk95LGxBjmVwTBUhH2K0y+9gDByy0fgwBfKNWaLTXl5qi71JwkyHqtsIa4A==
X-Received: by 2002:a17:907:c001:b0:94f:449e:75db with SMTP id ss1-20020a170907c00100b0094f449e75dbmr16815510ejc.52.1682450859433;
        Tue, 25 Apr 2023 12:27:39 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id w27-20020a17090633db00b0094ed0370f8fsm7235935eja.147.2023.04.25.12.27.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:27:38 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-956ff2399b1so1077503066b.3
        for <linux-arch@vger.kernel.org>; Tue, 25 Apr 2023 12:27:38 -0700 (PDT)
X-Received: by 2002:a17:906:b6d1:b0:94e:4c8f:759 with SMTP id
 ec17-20020a170906b6d100b0094e4c8f0759mr14744661ejb.38.1682450858375; Tue, 25
 Apr 2023 12:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
In-Reply-To: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 12:27:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwZ4pR=nqhdzPs2kpHPhmL=Dcy_-N4Ly3nvgUJPE-9FQ@mail.gmail.com>
Message-ID: <CAHk-=wiwZ4pR=nqhdzPs2kpHPhmL=Dcy_-N4Ly3nvgUJPE-9FQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Huth <thuth@redhat.com>
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

On Mon, Apr 24, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> These are various cleanups, fixing a number of uapi header files to no
> longer reference CONFIG_* symbols, and one patch that introduces the
> new CONFIG_HAS_IOPORT symbol for architectures that provide working
> inb()/outb() macros

Strange. I was sure we had this, but you're right, we only had HAS_IOMEM.

And then we had that HAS_IOPORT_MAP which was kind of related.

Anyway, the new HAS_IOPORT looks like something we should always had
had, I have no complaints, I was just expressing surprise that it
wasn't already there ;)

          Linus
