Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3235F9BE
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbhDNR01 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 13:26:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:47069 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234215AbhDNR01 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 13:26:27 -0400
IronPort-SDR: gGPiRgeYxKTu8ZDXfrkypIS182dZKfqBeTGCvKhvNHUp5H9Q2gsEDvUwTxmeC0URdGxtyJosfY
 JEZoTv13UOhg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194799797"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="194799797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:26:05 -0700
IronPort-SDR: aCgK6sJ6v3Sd9JwBKp2NvJfbWrjZ03o3vlE6FpkJ3IC5d9jYjwIBCCIuKlRQYoMYNH81qdJ5CV
 qTbLp4TDfmGg==
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="522065580"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:26:03 -0700
Date:   Wed, 14 Apr 2021 10:26:02 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
Message-ID: <20210414172602.GW3762101@tassilo.jf.intel.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
 <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
 <4a9dbfa7-db68-a2dc-9018-a5b74f0f421c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9dbfa7-db68-a2dc-9018-a5b74f0f421c@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> The CNA code, if enabled, will be in vmlinux, not in a kernel module. As a
> result, I think a module parameter will be no different from a kernel
> command line parameter in this regard.

You can still change it in /sys at runtime, even if it's in the vmlinux.

-Andi
