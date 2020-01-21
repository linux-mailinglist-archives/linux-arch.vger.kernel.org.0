Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B81446E2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 23:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAUWG3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 17:06:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51030 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAUWG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 17:06:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so4727993wmb.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DHa7TnxbIOsmyeSZxXaUWK1Ell61s+NmMCLvxItjFo=;
        b=wQLLblJDBIHGzkqNNorR8FPcykFhr9csTj6WWSAH5IRsQO+ZtETRbrf1zCbio9s6Tp
         VJ6f1OhBz2uUkm/DKjedaIZ+ZI4nWJACl+4/QmUg0IC/wig2tnXf7ubrKoiyxDaE2xYh
         u4zCSXxjdy+QP1EAPAS13so/dkuJKFRt6MCWhnQgoWEZn7wTFO0D0q3HzJkTFPFPGhcI
         YYZPSXxMtKiBUPHVs8eoZhdfkaiQ4ik5Evniwp9z9KNLYguDPchSXt9nZJkxeRqGqNYo
         CUAyPs7F0NyLbr+0eqplofWjsQ/0hVZ5GWiX4AKz/bnoFRGHYEmsU6p418Us3i+z7DFk
         yJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DHa7TnxbIOsmyeSZxXaUWK1Ell61s+NmMCLvxItjFo=;
        b=aeqX1qzdTH8Fx/1sjoW0njnfmqozbdNpVhwro2tT90TIAImuWAvkZ+LDuIEs/isLZc
         U+kG77yrMyGRKEoZ49pVcMXKlpaXgvevm/HZXW6KPHqpFWVYw1auig+s87OtW/FfAd82
         UcmdPC6ApUKSFz/CGbc8TElnRcfrdY1VmCTJZxvQxDPoY2HSAcWjj4Rhq9KcJ3PY36sB
         XOvrz2wlZH/KEVx0dIdBulad9i/NkNPYzTfhOKX5K3KpxbbOIuxJigFvIRYJvEdNF/kD
         qynvflnfJ579wlnhaZctcZcJo3eXXyQf1bH0DicSLPlv+Zn4sE5uCWFnCE9aG2HFKQr5
         n8kw==
X-Gm-Message-State: APjAAAX7YocHO/2eYnQhbQI+jKUY4QHNHJl6PZG3D6uxa2vQZGUhdWTZ
        se+1W0NM6vSq537nju6JqZdhxiYAThcDRo3thY5IXQ==
X-Google-Smtp-Source: APXvYqym5ElhGbj2TBisioR3/L296lisCvcxqTtBApfPRlGY3AwtbJjbfjivrUBRQ6X2b3l+gzox7owW5uYRlNE6kmA=
X-Received: by 2002:a1c:44d5:: with SMTP id r204mr432732wma.122.1579644386652;
 Tue, 21 Jan 2020 14:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-16-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-16-catalin.marinas@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 21 Jan 2020 14:06:14 -0800
Message-ID: <CAMn1gO6dNi-97cG-a8-6PcauLy9xpRvG6JYdU0zyn9a_6tnyvA@mail.gmail.com>
Subject: Re: [PATCH 15/22] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 10:44 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9442631fd4af..34bc9e0b4896 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -677,6 +677,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>                 [ilog2(VM_MERGEABLE)]   = "mg",
>                 [ilog2(VM_UFFD_MISSING)]= "um",
>                 [ilog2(VM_UFFD_WP)]     = "uw",
> +#ifdef CONFIG_ARM64_MTE
> +               [ilog2(VM_MTE)]         = "mt",

We should probably add an entry for VM_MTE_ALLOWED here as well.

Peter
