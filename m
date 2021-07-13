Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0F73C6894
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jul 2021 04:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGMCjO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhGMCjO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jul 2021 22:39:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5DC0613DD
        for <linux-arch@vger.kernel.org>; Mon, 12 Jul 2021 19:36:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n11so786629plc.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Jul 2021 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7+Hl5EQXAA6lNfbij3GoT+qYJt0dnNXSVM2lwMSK9I=;
        b=U+2CBuUpYEOICMFBAhm1xGggFz1QGJVfSdMEiXCWGhRZ8SjvbVH7YYYypIC4qotQM3
         xaCnZCtEC9rZiiqN1Py5qGPZF+9H269R2A4kSf8tDWO+UIEDLkPQf+fJBIDb4SZdOe1f
         pxHmAug842w894Oj+ERd7iUfccyNtBZLPkFkENvpVw5SAb6RDaA0SCK9MBSTFnXRES+T
         X44jr5+Zg8MdWLouNjC0DP2bd6wKFFBTvRL0ceWNZZceFm8nZwG8zIfocQ/I44CwCKIt
         kYz+jECzsJDGFTOr2hPS3qKelLrtP1LglBcfKjp50UrJUQ8/Hrd6se48vdAxLfbGL/rA
         lqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7+Hl5EQXAA6lNfbij3GoT+qYJt0dnNXSVM2lwMSK9I=;
        b=TkXfBxVyjp/XOGMQuGqOD/4UHebHzil3LaIYXPTLgLAml8DnNiVFFrBXVRz4/yeUPd
         dLdXEZAvTTEzNQ0odPxTGWPQO4mvPMCdJYsre8M5boJQfEtMYf4ift32W1ZBeK1j9jc/
         RZ02+Foro3MLT7IsR6GMfIWkaJS2RRSkVftnsp/L+KfeSFFh1Rld9K3AGz/fEqDNFFRr
         XOBzJ21r36upUXKshNpX5AZxr4W0gSCUbUsEeqN7WeXbkjFxV/i5ODcaNpmXAVxLeweR
         F5KHxdXn5/n+AlDrsvIbILUyCn3VifPZVxhjOMfhjxwAGmLJlsZLRELr9JOIG5o9JNft
         3Ukg==
X-Gm-Message-State: AOAM532lAQU7oETLOCpA+kkpvRSsXlxT/fZGrKWnwqAaJ0m0U9x2EHSs
        4e3q4gjp92WNbyLicoH5JFVBom6UAK7TXUkiS8k=
X-Google-Smtp-Source: ABdhPJxoo7AEcHJ31W75Z35a/6U4nnyXbK+9m9rNKjdaEOVzJOXRMWuE1FteGcZWG3UmJ495YO/yaL/TL2b9O7WNiuU=
X-Received: by 2002:a17:90a:e415:: with SMTP id hv21mr2000556pjb.178.1626143784589;
 Mon, 12 Jul 2021 19:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFOO9hwU3oS9Z2v-uqK5U_B+Sdy-whU3rd_BcecO3ogPHmoFXA@mail.gmail.com>
 <2c7820bf-e502-4fd6-8fae-2dbf46c94a7e@www.fastmail.com>
In-Reply-To: <2c7820bf-e502-4fd6-8fae-2dbf46c94a7e@www.fastmail.com>
From:   vivek thakkar <vthakkar.systems@gmail.com>
Date:   Tue, 13 Jul 2021 08:06:13 +0530
Message-ID: <CAFOO9hzvmeKAetVvX2-w=QKuG4X7BA-vLiiCxTMAq8fo3TN=zA@mail.gmail.com>
Subject: Re: x86 system call (using sysenter) perf regression
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Yes. We made a conscious decision to trade a bit of performance for a lot of maintainability, especially for a legacy-ish path. The old SYSENTER code was a mess.
>

Thanks Andy.

Regards,
Vivek Thakkar
