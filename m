Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDAB2C623E
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgK0Jtr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 04:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgK0Jtq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 04:49:46 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C6CC0613D1
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 01:49:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so4898135wrx.5
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SpT5mux3bkiG98XNqiWb/4fRNdxP5kYN/sKhC7Wqp5Y=;
        b=ShlgV2ihO15dKzZF7Q5JSurKvH/8b7WBrfBL3rXm98DSM65G0173YTWVI9zUisZ9z+
         s+srz7LcMlSJQVJgzweKt8t2Hh7GK5ff2Dkk3yXXtU3U0OgiBdlN5H601dPQZBpgoLRJ
         +ehhVD1z9uyWz9+aNcNOk8JE7SFYC+bNaorZR4oRE0oYR/0Ti/9s5/kaiiYrNDnzDF8w
         UkvfSFi4ASF4ELof6dCRRyPAa0AUptDfA+snYkAsPbzosOCQN13+EJNJFneHlrXy6t1+
         VLiALeOUTEJK2w1CAVJeZdDshRolAhPrfpgyb69Z+LDQ7m4VbZlHCQ1RIykRu+UluUac
         TpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SpT5mux3bkiG98XNqiWb/4fRNdxP5kYN/sKhC7Wqp5Y=;
        b=D04YCRYShK3z5YlnYazwt2YA67QYfmt6OSTdpB7FWcKvVMcXD+osHADa3rJeaxPHsL
         sgcFuNh6KojBS2/asPqE7l6phVQX9clh/FDufioqE2y9jXbpA8UwRbJ7E0RmYxpx/ABR
         A6Mg9OplGisIbPokSzNJ+5sLU8uRXj6JGM9t0Fflxkv97LTieK5i1sfpBmvRGX40u3WO
         eTCfdcw+4bS0dC7H9Zwiz3coDRD0QK1KDkeqwNdx7LCj05EZr50VeJ1eJpHiVggBM4yc
         TaSCGnQr/PqGfnvkSRTQKjd030mYVSyCWTzZYrunF9YFLFy/0NTC1QwUF+t6Hm20VRMD
         EhOQ==
X-Gm-Message-State: AOAM531xYeWF7XOazUDDNP4lFu95CRJaLpDQb3u0IxOC9k88j3x937L1
        llTcI7d0q8NAbD0p47F1iZE+jg==
X-Google-Smtp-Source: ABdhPJzEeC7rSvqMDDBHhuFjpH6cfspj1JR8WUhh8BLlTEHIhPiXR/gY7Yq5b2S9zICmvRBnj1UkMg==
X-Received: by 2002:adf:e449:: with SMTP id t9mr9451492wrm.257.1606470584483;
        Fri, 27 Nov 2020 01:49:44 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id g131sm13545886wma.35.2020.11.27.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:49:43 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:49:40 +0000
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
Subject: Re: [PATCH v4 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201127094940.GA906877@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-8-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 24 Nov 2020 at 15:50:32 (+0000), Will Deacon wrote:
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
> 
> Although userspace can carefully manage the affinity masks for such
> tasks, one place where it is particularly problematic is execve()
> because the CPU on which the execve() is occurring may be incompatible
> with the new application image. In such a situation, it is desirable to
> restrict the affinity mask of the task and ensure that the new image is
> entered on a compatible CPU. From userspace's point of view, this looks
> the same as if the incompatible CPUs have been hotplugged off in its
> affinity mask.
> 
> In preparation for restricting the affinity mask for compat tasks on
> arm64 systems without uniform support for 32-bit applications, introduce
> a restrict_cpus_allowed_ptr(), which allows the current affinity mask
> for a task to be shrunk to the intersection of a parameter mask.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
