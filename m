Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB162758B5B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jul 2023 04:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjGSCbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 22:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSCbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 22:31:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797F1BC3;
        Tue, 18 Jul 2023 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689733876; x=1721269876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oGVTTbOxHRTNujTz3s1LeziHKKP7JTarTS3cQdLkg0Y=;
  b=IzVRd8Ve768anOphKD3wStT5443OfOf9eV+fqvX5UTjAwMoGC8B5iUSr
   sNF3k5AOTHNItTtmCBYv2367M9rjX1ZjGLtR/c9PvW297I5GwK7ZhEOfL
   0Q4kd5yp1gE2Ypdwh3n2OhG5QDM3uNzZlLXdppnRC98EnuzUZnJ3z2yaB
   30LYh0X4wQLPqKlcAO8CouWTdEB8XbHW4F+ekRdgPtzuFtVjTT/1eCADg
   JrrHw5feCThvIBziGa3TLB2p5cDji8rSPSTYQ/xC2kmivW5EcyqlVzaMo
   xvOyt5ok9wQTMuXE3VwJ/XTNCwq4/9peEHyu+8biuWDjVdkiGy+d+QxyS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452734279"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="452734279"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793844259"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="793844259"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77]) ([10.93.6.77])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:31:09 -0700
Message-ID: <e3d2c81f-16e9-9a62-9fcb-d9552c3f12d2@intel.com>
Date:   Wed, 19 Jul 2023 10:31:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com
References: <20230621191317.4129-1-decui@microsoft.com>
 <20230621191317.4129-2-decui@microsoft.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230621191317.4129-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/22/2023 3:13 AM, Dexuan Cui wrote:
> GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
> error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
> operation for the pages in the region starting at the GPA specified
> in R11.
> 
> When a fully enlightened TDX guest runs on Hyper-V, Hyper-V can return
> the retry error when set_memory_decrypted() is called to decrypt up to
> 1GB of swiotlb bounce buffers.

just out of curiosity, what size does Hyper-v handle at most in one call?
