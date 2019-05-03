Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE012F28
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfECN3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 09:29:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42571 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfECN3i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 09:29:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so6618888qtc.9;
        Fri, 03 May 2019 06:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk5GUwth5BvvK8Eer/x9OS3rdg8YnckRm3ge9ViV+sM=;
        b=udjJ3UpUNLkicryui5X5J1mOb2WMgWCodfsJQGlDuMk/SooELJi7C7zXU4pDGfHq9w
         fKG40sQH/oyLJwOXLn/3K11Tx4o5xEho+FyubzHZ140rPretgeKEAn7Dwjvc6ScyNyeV
         PoDzekIap76f2Eum3l2RYNtVMIR5jLUcJ9prRgjPxtb69EetxOrE9Vu+kB0swWA2NEI1
         ZxZGVkGfWe8CerJ96yBP8TFUwAciYqK964tge1T0WyvEx7efd6admiICezNPowUtBBvi
         dGT+C3ORA92wo5Omp662NyaK9A43Cwi1c2EkazAp3d9SmU5y8WkndgaY6v8LBY4nT7S0
         iQyw==
X-Gm-Message-State: APjAAAULLxmAhup1nUJP2QhGqPLmUpgTOyY3KCznnGaSE/aRo3o7jbOI
        iicC4R96ieY8d0iRU+7zpEoVz8/OmFjNvoY+IdE=
X-Google-Smtp-Source: APXvYqw8ksabgFtpp8q3N/HfcPgRVYjc/VIhVGxEo5Nm6nyf24/EmnBpzo4QPweVmQKnq4DCKvnFaYM9qsG1Qqd+NVU=
X-Received: by 2002:a0c:89c8:: with SMTP id 8mr8014801qvs.149.1556890176895;
 Fri, 03 May 2019 06:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190501173943.5688-1-hch@lst.de> <20190501173943.5688-6-hch@lst.de>
In-Reply-To: <20190501173943.5688-6-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 May 2019 09:29:20 -0400
Message-ID: <CAK8P3a2-bFU=2Pmva9qj06JQ44MAW_D-Jaf_0fSExYm1yM8dtQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] asm-generic: remove ptrace.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 1, 2019 at 1:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> No one is using this helper anymore.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
