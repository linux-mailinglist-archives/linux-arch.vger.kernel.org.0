Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD46D2B8ED6
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgKSJ32 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 04:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgKSJ32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 04:29:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BEC0613D4
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:29:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so6078014wmb.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3JcU1zb6u51rjqw92Mq4g5Cn0LJ6Or+HL8YfF22EvLM=;
        b=W7Ip5bayzomghQnl06eSsIee8Qt9OFEXsbQgZAju7Tck5ryIp1znlAMWCoqtknPV8g
         7W9QBI+GXm8CVeKN0dmt1LkNVrGZSzQPCobGQsnqsZ6dOVv+gwgD1a9VjF5ZFDCCtYwr
         /EYieeI32R/rOVJ4pEC98SoLb/+N3OSHIvxHTMy+Ktm0yU1G/nCsQF9gaVaoNbz/PVTA
         VVw/g9QzJaFDotVxD4nVL2q8aRMe8BmPhEqNd0khTLpEObgDnT+AMBKhSGOYSCuGTE1S
         2DrWO4rBDWth99p4T/4QJrH5VDXlcuWC5NKtZqetOQLMQIeJ1+yk/V1bHfVxqIfaMBaI
         ijdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3JcU1zb6u51rjqw92Mq4g5Cn0LJ6Or+HL8YfF22EvLM=;
        b=RHEO3is7r1buma7WSXojtM2vW89SiJVab9tQT1yypxDBPDvEAasxv2LBAofA4NGcrJ
         wut/P5Ndgql8ycsanI6xtMKKkU8w9YEll9669WlWEOuoYWZWM+P9PkEzZQJi1jBbxaaR
         2WPsef4zG62cDuW0L3iH2XM/TpZQ8H2x4mlL0dXI9JpZ9+75YbCdf8ntPedt1VieVL4x
         1zIkKNqrCKp7f0kLg+wC+b8NxYr6v/8f+BGLydqTvLrT8AXiXjBKDIg6UEunLvn6+LiA
         oH9cXSCeEVLGxiTg59MSkOpcYYdnChcqZ2jpjhGZb6mEpY6DrVEPWLqGp2FM/jp+eUqz
         XAzA==
X-Gm-Message-State: AOAM532u9M+A0kWo2PXU1+pUOOOG0bE1UDzLc90oOgRw0r0NRdZxyQG3
        QysYKxrAUF0IhwOg3y7hiekNVw==
X-Google-Smtp-Source: ABdhPJzZT2RkNoWhXvP6tMmxJ/IWICezm7c5mwJnpHvk8eoIY48sGpyqV3pAwPLpkUwa+COXNIsc0A==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr3536870wme.0.1605778166295;
        Thu, 19 Nov 2020 01:29:26 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id j4sm37543361wrn.83.2020.11.19.01.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:29:25 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:29:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 09/14] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201119092922.GC2416649@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-10-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-10-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 13 Nov 2020 at 09:37:14 (+0000), Will Deacon wrote:
> If the scheduler cannot find an allowed CPU for a task,
> cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> if cgroup v1 is in use.
> 
> In preparation for allowing architectures to provide their own fallback
> mask, just return early if we're not using cgroup v2 and allow
> select_fallback_rq() to figure out the mask by itself.
> 
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Will Deacon <will@kernel.org>

That makes select_fallback_rq() slightly more expensive if you're using
cgroup v1, but I don't expect that be really measurable in real-world
workloads, so:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
