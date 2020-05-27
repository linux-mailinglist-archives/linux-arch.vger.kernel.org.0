Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796E1E4D99
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 20:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgE0S6E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgE0S5w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 May 2020 14:57:52 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A778C08C5C1
        for <linux-arch@vger.kernel.org>; Wed, 27 May 2020 11:57:51 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id d22so3114903vkf.12
        for <linux-arch@vger.kernel.org>; Wed, 27 May 2020 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fpy63c23dOxhykDpgNkYc0e/jj9ydzntDTyR3TzEzwU=;
        b=oOKshksVyBGLuBuCUd+quyrBbn2DnFXm50ek2FV+nnWC10Vc2Z+I/gtnZ3IypCD4Fx
         gXxBIP/wzAOJJn3wMPNcaKdJWfUFEnNJ5iy4/634yFP9C3y53gykgiFGJMLnkrv4pa82
         VbuMfy2wCmwUgkNUPBxU6zhgaM/LAqgX8x8OcC5SVPHdLp9OCdamyiEYDplt+F6T7rNt
         CZTpMTKKshLKGQva+1GCcfaQ41m4P/vZatfw8XQwBH6PLECjyYmMfm+6otaRyYZlkoJf
         +2He5a/1crn1NqJGKgI1w+i51L81dUzCLvEqmjYDk4ee1jckJiZXgZst1qGmRZZ/x/cZ
         mzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fpy63c23dOxhykDpgNkYc0e/jj9ydzntDTyR3TzEzwU=;
        b=C1vdyfSV12wmUpdlpgNwos8wCVFjs7q+48w1umBPhW+RDg2x+2Au6TGovRAkHjeKz9
         ztBzbmHPpasS3gmvX3+wDvkZaOaI695Q77CvmdCQj58sKwfCFBZoIaB8vzTuLUcr+VMZ
         4FLoZ+whDnDCmoVNvC4iMWYDkUuAylC3CPLNwYOuYQR4Kr2XwM9Ggk8a1FONQMmsg8aH
         q1UScjgpGOj5Pbq/eDN2sVseCoXpuJ3xUMCbTZq7gVAsKcGzUWwnG4USScesyjW67+ZZ
         FbM/j243IKjFSgB/zt04l0CKr5hHHmk1c4MejWV9eiKvNgku5IvOIz9xUbxSgzE5PYNL
         M4fQ==
X-Gm-Message-State: AOAM531oetBR6UtcokUmGYrXoR3Frw5ZRZIC6t7oLyFLtvLg12//tkYj
        JPsGnCEFxJ6y2k+MLOUIN+wT6FepQIf/3bfYkZDDUw==
X-Google-Smtp-Source: ABdhPJy5pnTtE6wlYRg72H36Ak9B9JFNQGA1lIglUkxy0n+VMKw19LyxtiwzE6wUtHu+jW7Au2sEYmLPPI/5udXhrcU=
X-Received: by 2002:a1f:bf0e:: with SMTP id p14mr6001114vkf.15.1590605870320;
 Wed, 27 May 2020 11:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200515171612.1020-1-catalin.marinas@arm.com> <20200515171612.1020-12-catalin.marinas@arm.com>
In-Reply-To: <20200515171612.1020-12-catalin.marinas@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 27 May 2020 11:57:39 -0700
Message-ID: <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> To enable tagging on a memory range, the user must explicitly opt in via
> a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
> memory type in the AttrIndx field of a pte, simplify the or'ing of these
> bits over the protection_map[] attributes by making MT_NORMAL index 0.

Should the userspace stack always be mapped as if with PROT_MTE if the
hardware supports it? Such a change would be invisible to non-MTE
aware userspace since it would already need to opt in to tag checking
via prctl. This would let userspace avoid a complex stack
initialization sequence when running with stack tagging enabled on the
main thread.

Peter
