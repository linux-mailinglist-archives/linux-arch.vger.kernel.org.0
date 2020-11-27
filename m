Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27AD2C6242
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 10:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgK0JzA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 04:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0Jy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 04:54:59 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E6C0613D4
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 01:54:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so4893448wra.11
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JjE5v+XtmXi4bhjUhwczYi8qu3IElsPJc6z70wBzRWs=;
        b=sfYOdVjRyzcbYRH/Ekm8wSub6oWEzdjbW2nDTAMnh+6ng+DbEs+mHTZUhXoUXiM0G/
         6hwWE5ZB2yeEMyCagbn48ngqnVd/Y5klQdMiAfN4mVSz+nY3HGFLtKuBtYX2clhCpvIG
         IuMvX40k0Uea4kH/0bOWOe35Y2bAVJs9VJ3/XgrZZsEVzh5EmsUsIr9iBr1J9hIIpQDR
         VvDvVN51IOVbbbe2X/suG6Ry3Slx41rPnME1ldpGZ+vwcCoSp4U8fYOSjwtj9jIHVz9v
         QCd6icNy7782CsjPEAlFmgSBNUV3YZN26AsSirMGaHi1jQF+cbbTSiArlLUnRo9sY/Z5
         tARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjE5v+XtmXi4bhjUhwczYi8qu3IElsPJc6z70wBzRWs=;
        b=ES1stdNdG3DrY5IUcLCGyTJFzEDiFYUeqMbkxXKZ0oi6rqRgqxfXX4ph6aVpSLgGip
         ug0Ev6K21VeQEv2pe49RpNXt9QhgN+CPmGrlnZk5V9URl7ECZWy2XsaG7IvXICB45Nm1
         tvfnJb4IVtsDXjgaAVQNU6IpN+dLHkaKQacMBTDvPFuQX63wp1TbbzZC2fjtybjnNWG5
         MmdDy2+vTaKPZrXpfWXUahy86tGl56aSemzH4c3KNT5A1nENjPyEx7piJ0p7+Udyb7vm
         OHoTLBioUx2ZSkEEFcVoqmABUpuRAfn2uWPdonIKDhrYBl06lJkgag5XjvbPHbrncboA
         6whQ==
X-Gm-Message-State: AOAM531KNqzw/wVcNl3n9WJcmOC3jPNCQPmshMqoEPBZ7zQcFU0ZMirK
        N/eCgVbe2MCTgHUv36ZqphSHug==
X-Google-Smtp-Source: ABdhPJy8MKyha3Xk7UYSRiRLy3TVGJobBhb4KefTjlDXAMCo/TeSUVelqvExxjIfnbZXHjD1GJxklw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr9079635wrm.44.1606470896481;
        Fri, 27 Nov 2020 01:54:56 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id j127sm14205428wma.31.2020.11.27.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:54:56 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:54:52 +0000
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
Subject: Re: [PATCH v4 11/14] sched: Reject CPU affinity changes based on
 arch_task_cpu_possible_mask()
Message-ID: <20201127095452.GB906877@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-12-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-12-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 24 Nov 2020 at 15:50:36 (+0000), Will Deacon wrote:
> Reject explicit requests to change the affinity mask of a task via
> set_cpus_allowed_ptr() if the requested mask is not a subset of the
> mask returned by arch_task_cpu_possible_mask(). This ensures that the
> 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> executing it, except in cases where the affinity is forced.

I guess mentioning here (or as a comment) the 'funny' behaviour we get
with cpusets wouldn't hurt. But this is a sensible patch nonetheless so:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
