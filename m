Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6022B49B3
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 16:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgKPPoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 10:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgKPPoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 10:44:02 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBAAC0613D2
        for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2020 07:44:02 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so25736826lfq.10
        for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2020 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oivIdgQaz5+Gp2NLctXgWUVrml124AnA4kh8cM9g7mM=;
        b=uacpSvyg7sNcaRSGZ7Q3s8sTWe0zmTrFvRT2fZ38n++Dg/H+rJ57tNnHKW+Nn9wRY2
         xYrUSAFI9AREFZuosouqgZ9Od7ZUxEJ8dHq4guk/WYcKvzkvUDLFspZJrQhNaRVkDdLW
         1GWD1S9qA8aMOaqIZb349wy74E/CQDpFlvouD2b/tOIu5CK+5cloUZlhO6BW4sb3G/Xr
         BwhGxYp3w9yXabcKrrLw4EQC5eQhlR4F22zf6KrBG8tYkcerLZVgRRUnP7yqzFF0fdIa
         93XPaoPWr21DOOO3u3riLFklco7wH/gsEkrEsZwe8rltgtblHLC8qusqEu6duJ+CGIyS
         CUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oivIdgQaz5+Gp2NLctXgWUVrml124AnA4kh8cM9g7mM=;
        b=hL++hyBysYvthpaTk4gRKP7/Lj6aY9yFds9MBmf2EqScyRNrYwVkgJ73z0BmwR00az
         RlmbJ8wzqim5P72srMNDsbZhNEd73pKsd1DQEM/Hf0nd+LyFX+JGembbCL3TNFQG5O2v
         uG8RvojCoE0qiu8RECR76yoOPSLzOdxlicpd++eBC9xUhTXmfIxMVka7v/WiXTKWRSFi
         o7IFP+6HdZEjJc3PtGCxDtTNLh+Ew5btWfVfg7cINO/B9zhFDJ2hRJJ6h36a+j7tngMb
         fzHdtgYOP9jFWNkdTrCHIqxz9L11O1HcCr8TOPWrOOdZSKGUReDTcl3dKNC7QJP9/O4h
         Q+Uw==
X-Gm-Message-State: AOAM531+O08t1dMDgbT0pRJjbAbp6B1Bhvkn619yh60fznDJGniuXjMk
        tVmucylQSKGSwitMl//5vuZUcQ==
X-Google-Smtp-Source: ABdhPJzjLRw9j/vxUGUr0fVvvk1nlQOO9whebEt/gMYFPyoxALUMhdZDkMeMEsHU7VarRhJKNWMJuA==
X-Received: by 2002:a19:98d:: with SMTP id 135mr6966522lfj.357.1605541440721;
        Mon, 16 Nov 2020 07:44:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l17sm2796682lfc.221.2020.11.16.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:44:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id BA192100F5E; Mon, 16 Nov 2020 18:43:57 +0300 (+03)
Date:   Mon, 16 Nov 2020 18:43:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org,
        davem@davemloft.net, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-ID: <20201116154357.bw64c5ie2kiu5l4x@box>
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113111901.743573013@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 12:19:01PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> These patches provide generic infrastructure to determine TLB page size from
> page table entries alone. Perf will use this (for either data or code address)
> to aid in profiling TLB issues.

I'm not sure it's an issue, but strictly speaking, size of page according
to page table tree doesn't mean pagewalk would fill TLB entry of the size.
CPU may support 1G pages in page table tree without 1G TLB at all.

IIRC, current Intel CPU still don't have any 1G iTLB entries and fill 2M
iTLB instead.

-- 
 Kirill A. Shutemov
