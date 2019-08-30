Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3EA3EC7
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfH3UJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 16:09:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43103 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfH3UJG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 16:09:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id b11so8945212qtp.10;
        Fri, 30 Aug 2019 13:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSz43+HaqBFF1Ng0B+1T6nx7xlLwk6j4lqf7D5VIcws=;
        b=Te7I4oItEgvT+NWb9rFaghIkBtJvGp8XCCUvpDl4IwCW8LYDWxbA3FeYJykXq3yrQr
         RgClfkVFNOdsTeIzN0yicaH/IotS4Z5L7j/IGTUliNQiEfloHD8GwHPUhYpmay9o3ddT
         XCQD6rxvDHnRN32LFb03WXeWPiqwfIzUhr8TLXOkWEujG0QOBa1aWjqgBunqVWXFT3sD
         kxkd22YEXS9XOQFvnYP4pJVcSpu7f8LZOZbd6pk7MO71uuqrgos4ME3DWYa3xdLBKoMy
         krep2Cnv0DLF6Vf2ZnOM3kISLWjeXLjQfxjCjH1TjXe/0Knf8SWL5Bh+VsHGeetyHu3l
         shBw==
X-Gm-Message-State: APjAAAXpKUE5ka3OraJ/JA5Qf1Cie2+/9bopAdIo1ISdHoFCqfKbcJM3
        qIj56TYcnDVWqFx6+ZWUo04cOGpijY58bBSbGpE=
X-Google-Smtp-Source: APXvYqxuaGEEyWbbVoV2B3tqVUOjxwizqZzgkNMis/E8MNgJ0bdU2Nj37/z0UlOREhwaxP3xoIfFO3LThACiGdB/jtg=
X-Received: by 2002:aed:2842:: with SMTP id r60mr7786550qtd.142.1567195745253;
 Fri, 30 Aug 2019 13:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190828210934.17711-1-efremov@linux.com>
In-Reply-To: <20190828210934.17711-1-efremov@linux.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 22:08:49 +0200
Message-ID: <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
To:     Denis Efremov <efremov@linux.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 28, 2019 at 11:09 PM Denis Efremov <efremov@linux.com> wrote:
>
> Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> the define consistent with BUG_ON(x) in CONFIG_BUG.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>

This makes sense, I've applied it to the asm-generic tree for now.

Two concerns though:

- adding unlikely() can cause new (usually false-postive) compile time
  warnings to show up in random configurations, so we'll have to see what
  the build bots think

- Kees Cook has recently sent a series for asm/bug.h that was merged by
  Andrew Morton. If there are is a conflict with your patch, it may be better
  to merge both through the same tree, either linux-mm or asm-generic.

        Arnd
