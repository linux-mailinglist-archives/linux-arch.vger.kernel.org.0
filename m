Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8309D21F62B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGNPaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGNPaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 11:30:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF4FC061755
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:30:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so23300003ljo.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvONWUUx+ge2aRqADFFqhcoKfa3RbBALz1DV1ooGJ/Y=;
        b=XijJsNpSPPnejytiYcdHjB1XQVu8uaH3j6/gEPYZl+pAI0TcIHWcBLqvOFrhR7jXBP
         9cveXgeLbceG8D7dAL+Zepto6GIlhPMkZ8CJdbQEnOtls2STHYWDEB8MFah9uo0hpegd
         YSVwiX5OVwFQLLXykgySPxhz+QTAG24MkW3WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvONWUUx+ge2aRqADFFqhcoKfa3RbBALz1DV1ooGJ/Y=;
        b=IGqFPo15swQJ/knxE13e7i8QPF2TFJEq6avWaoGLkKSO0etv4VzW8YtM5HTDTnx1KV
         4Qabw3yty1JMOcL+SJqjbN5oBt+ePjI13MB3AOY+xmIwbdYQhbGRSb0CMSFh7IFirrAs
         jSSh2+DUQIZCpMyEYdHdPKLyTGndLMsI/TrfUH8mdCnFbXU6VBsHSwaHpJYXTcW6oNGA
         UEmv829zHjl5j3QVS+zYYywf8gKIVbpjx9YEe/EtkbdvaWlv8DPE8P8Lq4RoeA+5e3gG
         gctjI2jVPOeL7HE1xMI84osSCcfVfZ9yTcAiLZguZuJnsEa2rr/KFRpq5jDF2RrawpCL
         HUcA==
X-Gm-Message-State: AOAM533OOch1JADjiB/5Kx9DWjf2LAJ04HcdhymN28I1tfrz+7OcYEco
        OLmmTkXSLhhyy+vEUpoI6Tmm+KHMZjc=
X-Google-Smtp-Source: ABdhPJxqAv5avrJQIXTCxoz9o9lUsnl536LsKtQLxpFCpaWYipxJCuae/srgA9ado0d8YNbdifg3lg==
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr2811137lji.80.1594740600767;
        Tue, 14 Jul 2020 08:30:00 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 193sm7266523lfa.90.2020.07.14.08.29.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id d17so23310475ljl.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr2752959ljc.285.1594740599299;
 Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-6-hch@lst.de>
In-Reply-To: <20200714105505.935079-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:29:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvwd9AWMCoUidO8pT3iw6e6NXCKThqbpDQOoz1=WTP7g@mail.gmail.com>
Message-ID: <CAHk-=whvwd9AWMCoUidO8pT3iw6e6NXCKThqbpDQOoz1=WTP7g@mail.gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 14, 2020 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add helpers to wrap the get_fs/set_fs magic for undoing any damange done
> by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.

It would perhaps have been nicer to rename the save variabel too
(neither "seg" nor "oldfs" make much sense once you get rid of the old
x86-inspired name).

But from a greppability standpoint and a doc standpoint, I guess just
renaming the function is sufficient (and certainly easier).

               Linus
