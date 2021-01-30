Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA90309441
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhA3KSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 05:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhA3Arn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 19:47:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726FC0617A7
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 16:46:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g3so6306584plp.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOYufdKif/Scq2e39hV/4HV4zK+OLCAmzma8mjBFh2U=;
        b=Wo0ro2Zy8l1+MQXIt8UlVk5b6AplAXNdT6fsrb1zdWgJxtT15PaLgslD8sAUfzRAXw
         cts9oMJtp5dFVyjMtdnwhlpt6tOrxbnuAMnTcYxxU/NDjNvUMXCF+IgEIgBZ8g8VWnUm
         y6a4HSKvO0kPhzfKtp3zrEJG6YYPStkeHjijWIAH2mjTMyOHLF6YI329QCLHOI32+ecZ
         4LII6Wv4g+Zs4PeziTIpqeUwTtY90X7Jx3kG+hgDXC3YN2y8UooN7Ixjkeobv+A+EFWJ
         +01KxUkWillNj8avz/zzwkFjuwknN11Wpe3M00D6eLhHqBImGhEoeS8z1QpwqeuV4sLz
         +tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOYufdKif/Scq2e39hV/4HV4zK+OLCAmzma8mjBFh2U=;
        b=CAMGW6thO5kz+CbRKVEloHx0NUkWpX2uOUMTwR+9ZOwcfwpeOVkZyiEaXFUlikAq8s
         NCXEcLrKeDh7eiIh3j6AhVMm8YHEJaHw/G4KajTiG4QZAB05WhFN3P7cRrEHwAYow2Mf
         6nDb/Hlj5aeAWyNE0Uv5RdEYK2Za9csmmniIb+DKIPAXjw/CBylAOc7jVlFCSgf7HRkN
         DgcTv0fIZ4DwV46rJAIo+WVj69v86wuNVi60dkG9oAFUmyyJ4H0qST/Mgxm25jd5o/aB
         to5Bj/6/k4mfmobsi33xX9LZwLdVLLVBo3yeCorF3FfR24M41/dTAZtSm34r73JUncP0
         p4Fw==
X-Gm-Message-State: AOAM531JjlS/rQdHv/v7+JAQDLiOKktkeQqyjU6xBCr28YStDP8K0fNJ
        2miVNfl/RBZTfJ6CnYiqMvPW1OwIAvu69mCa3CpMQA==
X-Google-Smtp-Source: ABdhPJx7TQwRJujg6Rf1/nJXAq+yZpWh+nkOZ6cCyjORiT8vUbQP5fbUn6tjd8b8ruQik8LP/r3Z9rCvG324klwKDNo=
X-Received: by 2002:a17:902:ed94:b029:de:8844:a650 with SMTP id
 e20-20020a170902ed94b02900de8844a650mr6915188plj.56.1611967573031; Fri, 29
 Jan 2021 16:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com> <CA+icZUXpn_VKePTpnEhcpuSxPkuQTSKYfsVeMbxU9-rBp1ZJXw@mail.gmail.com>
In-Reply-To: <CA+icZUXpn_VKePTpnEhcpuSxPkuQTSKYfsVeMbxU9-rBp1ZJXw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 16:46:02 -0800
Message-ID: <CAKwvOdniSiaBkGOO32ZuGCv=1SBwaqdRsHUo31n+O+g0ek5P_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 4:08 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > DWARF v5 is the latest standard of the DWARF debug info format.
> >
> > DWARF5 wins significantly in terms of size and especially so when mixed
> > with compression (CONFIG_DEBUG_INFO_COMPRESSED).
> >
> > Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> >
> > Patch 1 is a cleanup that lays the ground work and isn't DWARF
> > v5 specific.
> > Patch 2 implements Kconfig and Kbuild support for DWARFv5.
> >
>
> When you will do a v7...
>
> Can you look also at places where we have hardcoded DWARF-2 handling...

Ah, sorry, I just saw this now, after sending v7.  Can we wait to
purge DWARF v2 until after we have DWARF v5?

In fact, if they are orthogonal like I suspect, why don't you send
some patches and I will help you test them?
-- 
Thanks,
~Nick Desaulniers
