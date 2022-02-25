Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125E4C3BE2
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 03:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiBYCpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 21:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 21:45:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD5726F4D1
        for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2022 18:44:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id i11so7082238lfu.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Feb 2022 18:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=csuOdVPD9p1war0jafYA3tNk8YcebicwAuViflf43go=;
        b=QlCpIkZsflPeBDVUjYxTbZS+XDPiWoZhC0aQHOVL86JcsZ0FEejHT1L1RI2vm7oFxW
         8JBYfUPaBZ1tXF2IxT0XsQBH07wIq/rUS5uCDv+zWZvFHE00s9uU/AYe9++ZQQM88DZs
         f+TEhEajrnGzg1e6kUV3dvR0UVn9SHwhYM/U8r8LXoJa4FTutgEpAkeZmuO0TqLi7GY+
         31jcfNw2BSSbq42LydhEV3AMMdv7ye2xe65JBLtk3cjV+VvAoT2WhNxvBSRruIeGXAvQ
         hf3UnP57VkoOG+F3SofUrQOzkFnCobf9vcjiAqpnokHmX3MhlaxKkqV9Z72nNN7I6cDD
         bFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=csuOdVPD9p1war0jafYA3tNk8YcebicwAuViflf43go=;
        b=w8q9MB/pUCsKjjVpT0IpG3tn3GrDYW0EQVA+FIUzM2iG6JxVP5lPJMFkhnGoWbaebJ
         NBQS+bPYOyh9Q/ROsoGA5W48GhZo0tAtg5K/cFzwkBq6ZWSxrb4bwk/TlF7jo8ByySJU
         U/NlN3K9wNLOtBXwG9VX5ouat9Z7BXOViHvA3+O5dJivk4OS1R9U7KmYRHBJmYAUeLb8
         rE3M62M2Cw7ikCDHB4FqwsHD3HpNL1SGPGVjscm1gzxeXwsckn9XDUhzrJ4yKKpeS26y
         DzMVEz4J0jDbDwLhQt5EiQOVwdR67+6qdEBatL6VmgqyEog/GLmW+aBvExwpt7z4omQj
         ERDQ==
X-Gm-Message-State: AOAM530bCIj9oblj32TW77Ok4Hp/KrTJr1SPPrYDJTJ8xZEFlsey7Ca3
        UalnKE3sMvuHQYkODzBUWEzOLXtenGsPhk7NQeRo5r4fU2vSWQ==
X-Google-Smtp-Source: ABdhPJz+tDFJTNac/BGJwSbgswgJYxQWseLHZktFw9/BUsb7fuTLvZ59SlV/EES6NBkeWusyYGylt9uX0flaryYv85c=
X-Received: by 2002:ac2:4156:0:b0:443:1591:c2be with SMTP id
 c22-20020ac24156000000b004431591c2bemr3701178lfi.234.1645757074718; Thu, 24
 Feb 2022 18:44:34 -0800 (PST)
MIME-Version: 1.0
From:   Yimin Gu <ustcymgu@gmail.com>
Date:   Fri, 25 Feb 2022 10:45:25 +0800
Message-ID: <CADE7KV3JiY24JaMCLztcE9ih_hZ-BsT0_2Y45DMat9rPWkBXLA@mail.gmail.com>
Subject: riscv: 32-bit adding __ARCH_WANT_TIME32_SYSCALLS for syscalls
To:     linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In include/uapi/asm-generic/unistd.h, syscalls guarded by the
__ARCH_WANT_TIME32_SYSCALLS macro, like adjtimex, are not present in
32-bit RISC-V kernels because the macro is not defined for riscv32.

Will it be good to add the __ARCH_WANT_TIME32_SYSCALLS, as well as
__ARCH_WANT_STAT64 and __ARCH_WANT_SET_GET_RLIMIT macros for riscv32
in arch/riscv/include/uapi/asm/unistd.h? I got uclibc/busybox compiled and
run on riscv32 nommu systems after adding these macros, but I'm not sure
if there's any potential problems.
