Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62373D18FF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 23:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhGUUmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 16:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhGUUmF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 16:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9861E61249;
        Wed, 21 Jul 2021 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626902561;
        bh=wVXjBvnDqeBXxEgGrM3dHFzG2SEW7Fk2iOjM5sBOS3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CPyUZzWf3CDK7aK5PD1pTusv0T6/pupkiQsuurXls4hO4sNAxIwV+jQVYXlBZmwXh
         LDUQWgfE4DW6lkMFdtbIohMGG07t31qNWAxn0afoU/w1hC1SFcm4aN7xCG4gONOv2Q
         jB8JvOMguRgCGfMGd8g49EaFyPERsqT3l/Vf3ELRgoLlyBnP5Sdw+PSlB/lVz1ZaBv
         KR2NGXvTFvP3telRK40WfyXRTu0k7V16sVatXbWvx+Jiv+O8RCDgWMphwpltkGOVk7
         pQHSDSO8RbNussXEZpfgkk/8xwxIypyu79unVlndVEN5g0hEAe1jt6JOtA+N/lnkni
         p5in5soEKvsew==
Received: by mail-wr1-f52.google.com with SMTP id t5so3611605wrw.12;
        Wed, 21 Jul 2021 14:22:41 -0700 (PDT)
X-Gm-Message-State: AOAM530BMhMl6OI5bw3pl6Ei56C5S5IZLUYERFXUytyqylFlRYJNBe88
        LJW3NN7/tBxIkdai3es+St+WYs8ul/NkS0x6czY=
X-Google-Smtp-Source: ABdhPJxch64cTukt4PD+FaRfYlbdrPaAFs1B2RT26cj4vvJbfUqAnPkx2+be51IRpr6rQdKNapYLDFkqa48ysWy0vS0=
X-Received: by 2002:adf:f2c6:: with SMTP id d6mr45877743wrp.286.1626902560213;
 Wed, 21 Jul 2021 14:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210720150950.3669610-1-arnd@kernel.org> <20210720150950.3669610-2-arnd@kernel.org>
 <YPbtsU4GX6PL7/42@infradead.org>
In-Reply-To: <YPbtsU4GX6PL7/42@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Jul 2021 23:22:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0OkF1G2kNTnn8Nh5aGAf5nnHNZqoQD3TB7mN2_VTV_9w@mail.gmail.com>
Message-ID: <CAK8P3a0OkF1G2kNTnn8Nh5aGAf5nnHNZqoQD3TB7mN2_VTV_9w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kexec: avoid compat_alloc_user_space
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 20, 2021 at 5:37 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> This can be simplified a little more by killing off
> copy_user_segment_list entirely, using memdup_user and dropping the
> not really required _locked wrapper.  The locking move might make
> most sense as a separate prep patch.

Ok, I've integrated this as separate patches into my series now, will resend
after some more build testing.

      Arnd
