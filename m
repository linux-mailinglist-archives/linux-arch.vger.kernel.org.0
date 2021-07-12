Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BFD3C42CE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 06:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhGLEU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhGLEU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jul 2021 00:20:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0815DC0613DD
        for <linux-arch@vger.kernel.org>; Sun, 11 Jul 2021 21:18:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso854161pjj.2
        for <linux-arch@vger.kernel.org>; Sun, 11 Jul 2021 21:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AE4H0mOW53fB8xSzffTqudaUVxMvEGDF7FbuMHzYy0M=;
        b=ORQLo5mM5rJoNceWaqZSLRGRK+x+l4H0J7qZV9pkWN+x3kdHgD75AlXpKE/3gP5E4S
         hNs2ybFK50zjwTPvaIJdwsuDRjaVhw3ZeCSrRTkbSumctrtm2uSSQZUCP1UrBMJ5WPeZ
         rRzLO0ktsXRsfv97mE1eWWLnqmtWOS6o6X4CcHRsHlKSTVGq17Ja5eygyhfpTNKfVsY3
         Cy+RY93C4D80QpQASQoUHAqgWMdyjxWrGSJRS4vRxlEklFrEpOcbwa3P7MYQL5uLpc84
         t42AJ5bcoxmJnpSbwUB07o9Z5mztdU4XjOvQK00Cz4f5HHd+bM6foIY3ZWFtqukMWWJb
         9PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AE4H0mOW53fB8xSzffTqudaUVxMvEGDF7FbuMHzYy0M=;
        b=XGWx0dSnkKN5flh6auU1aSE1gMb2PEwtkznzR9CA8hSdnyh/AaNbIuOkliBoUl4gJU
         4r2DimYNolTnCopvKrl8/zfoMGp0U+wm3SQZanuHsf8s1hMDcX7T9dKJcR6vZm4YUZQi
         1Lt/H46yEWeZ8dLjiWbKmroClKBvJs1a6GeYIs3mBIMTlnUXwNHdGMRi2IMh4aS0BZS3
         XeD7Pd97zPx6puQZbz5KG55xA4spmkHSgbXODZxQ58PqGUcIkOiT3XYJqkBlhG9W5ye9
         DO/55AqXe1qu2bxWirmiUeQzoXO2xu0FeafnqhFphjv1St31giNwJNv+TZD1xthA1mkL
         qGZA==
X-Gm-Message-State: AOAM532MzGIz0vrFOibQ8bra0WstVTOfByOmpH5ewcz21HYsEyCmrNMH
        FjBrWoblKYlu9olzL6wxxpurciQKZmjMMkblXiRwwfuqs0o=
X-Google-Smtp-Source: ABdhPJxVZuGK9Zj/IDlFtYk9B4KZkZXMIMMpvncHJFxXuhn4Y3VfBQ4jATZvZvsEjuvYzREmWV9bg3N2x1qZZgBOd48=
X-Received: by 2002:a17:90a:e415:: with SMTP id hv21mr52005272pjb.178.1626063487527;
 Sun, 11 Jul 2021 21:18:07 -0700 (PDT)
MIME-Version: 1.0
From:   vivek thakkar <vthakkar.systems@gmail.com>
Date:   Mon, 12 Jul 2021 09:47:55 +0530
Message-ID: <CAFOO9hwU3oS9Z2v-uqK5U_B+Sdy-whU3rd_BcecO3ogPHmoFXA@mail.gmail.com>
Subject: x86 system call (using sysenter) perf regression
To:     x86@kernel.org
Cc:     linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We ran a test to measure the syscall performance on two different
kernels (v4.9.x and v4.0.9). The program is as simple as this:

for (int i =0; i< 100'000'000; i++) {
     syscall(SYS_getpid);
}

The program was built for x86 and was using the "vdso" mechanism to
generate the system call and we could confirm that it was
transitioning into the kernel using sysenter.

We find that the time taken by each system call takes 10ns more in
4.9.x  as compared to 4.0.9. On deeper analysis, we found that there
are 40 more instructions that get executed in the newer kernel version
- the user space transitioning mechanism based off of vdso remains the
same.

commit 5f310f739b4cc343f3f087681e41bbc2f0ce902d
Author: Andy Lutomirski <luto@kernel.org>
Date:   Mon Oct 5 17:48:15 2015 -0700

    x86/entry/32: Re-implement SYSENTER using the new C path

Is that something that is already known to the community?

Regards,
Vivek Thakkar
