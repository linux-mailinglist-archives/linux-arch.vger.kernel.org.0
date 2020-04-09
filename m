Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006541A2CEF
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 02:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDIAlx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 20:41:53 -0400
Received: from sonic308-37.consmr.mail.ne1.yahoo.com ([66.163.187.60]:44624
        "EHLO sonic308-37.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbgDIAlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 20:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1586392912; bh=/6EYCRlfa2umBwyf6HMqnS88iYA4EIXadLKaqqSMGXc=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=Nw9PSYl5kPo55rK57kdK+1rouIyZmFH49XmlmNnt+EPGCmzv5/R562708lCkK9bcS1996WRvY6AWWRgP5phZau+eJxoQmqe+LtCwNJEbiYUjQhQT/OXacraRjiO5WRZ8qsSlVAMXGIKXGWVMix1s+I5tt6JSaqGsGWqa8zr1hJE6ZyAxPEoEYv5ZFlm/QM4zwfuDMMiG5yQiMafwtotoMJIbhnQ91EvX2WyiEWFjhDLOt5DLpnzrXKB58PBcZ/9RDKamP6jFx1FoPm8nUGivG9s/e+4lgHMoB8j5kGsRyJMdGA9c8cLBXg+peTceR8BZpBB9DLsp3YkeaGOsTusoSA==
X-YMail-OSG: Kjs_hFQVM1mYR3Bbv__auOf2fhoaIk9dbexLkMUvZvDcgibPrEIH2uN_nb7TSk.
 AjTVDttprz38pf2agkDENCO9OlpstM6AKa5fqJSzz9g9BDnD9cEKZ6Kcqg9CatwzLNYThMuSUeYX
 2yEgN2U8e5xgtZHtWmAFsIbznPJD_UPhljYJl2r_EoL5qqrqeJu9Nnd9Y.Ff.0cQ6SO_SlnVXMbj
 JYEgiFEkwq6TWViREF0oZDh5a7V1WTHk_fQL7mKo.zfkeUUkf9r2PC3YbrlM36YDrBNE7Vu_H_23
 7SUm_oYUdCkn.imVzOSTsbg1UKej12C_c6DVKmb2bShJF7ckagBec7h.F7Pz2jADVU.RAf_SzeRw
 jnXQU.OYwZs7DtYvRPtgjcVfmgAxeq8RUp0VPoOeRchdyRoGHKkYEH1l0ufQv3CAgRqC9S3zsOd9
 fnhObZjDMfX58eXYxHjcxjHRReqFOhx5Hz6aq8FIq7jw8y8OEbWPMrjaCpR4FKEn_bozdR4qyDFm
 4sbsu66FrZifwa3kj9UeUr.wGSL5S042VmSyGfETFpHOTRvx51GHTkDHF4kqnnRQjnt9cOY_TXoy
 6ikjZzl8Rym8MnuDSY3t2UEnyXfrQM8zmKcZMaBXZA.1JruNMW__SZDUsuarZwJACQIZFjYaEYcB
 6Fx2cC_OXlNG7d102FBbLxbbWE51eCCn6.Ao3BUdftIqkSfQqE8AmEChvpnb3Hjczsgr87hSe_ZY
 FNPGuabtMxRjTV5vOhJN9EVsFZjNMIpNdxApHaOp9BBa0mK8Hd4Y8_sLLzgFE_OX._p_ww8OgQCS
 _PZw5TJANZTRxfmtlnIT9WY8nJxFEz0ZzkRbyJrD7lBRVCuL2qRMMrbnVCU.d3atpGGNT71.FMTl
 XJp9kOjDwdiPhEHaNTf0wy9.286eHx9hDHZx13ycI4lCw.BNZVla9tTflJZSkBR622oDAvju0pYi
 chnjA_f0d_Rs3Y.w_0UWDDtsiqrp7Nd.ENOvnjBk3WtBBjbeqzYHxInpU0ICw.akO5xUiF4HXGRD
 NGu7bFyqgIPHiVSYVkpfC.PnR3fZmrfgYy1Ktc5D_y5Xh2Z7vFADl5LC6uRiCqJ9Y4yLuHo1ATrn
 PxNppKa486Nn86yT5d.pKQ3q49VQAxNEB7EGZ_QmK0uyT9X6oF2qpuwBBPhXWKUMiK3EbPuATGVw
 L.4MdTecfHCHslUWJtwrtw2v46CslPDJY3TtzPBEF3b6hKOBHSxZ.8CqTxF3S2_xcA64udxpFdja
 9c_vKNU82cTswpLxDeBimIz._J7Xaum1i6dZEwCbc.uspehQ3L04kL45bX0fhpi7dDoUJat5aE3S
 p_Fl8AHbSq3P.bkBJGmoklW4vRdsCXSUz4v5SYoPxJ86d1eVDsQ0qrpylWpfgRvkXgRw467FBrzC
 _ECRk3ijYTNyDsC7idxPty4i4XJSa9KM2uH5RWvaV.R8phY0hHU.lO54DG8mygB9TxdZscMBwbtP
 JqFlYvAh9BGSO_QyxpGrs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Apr 2020 00:41:52 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 07bc1f76d2033b5244ea2e327c66bf87;
          Thu, 09 Apr 2020 00:39:51 +0000 (UTC)
Date:   Thu, 9 Apr 2020 08:39:35 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Message-ID: <20200409003931.GA8418@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-18-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 01:59:15PM +0200, Christoph Hellwig wrote:
> This is always GFP_KERNEL - for long term mappings with other properties
> vmap should be used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c   | 2 +-
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c  | 3 +--
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c | 3 +--
>  fs/erofs/decompressor.c                            | 2 +-

For EROFS part,

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

