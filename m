Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC965FE8B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jan 2023 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAFKLQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Jan 2023 05:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjAFKLD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2023 05:11:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB514017;
        Fri,  6 Jan 2023 02:10:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bt23so1339183lfb.5;
        Fri, 06 Jan 2023 02:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AvodmV6r1uh3+mDTSjqcwni55KL3aLeYcKEIfJZqDE=;
        b=IvCRei3g8gBwnMnOIOO1U/i1B8SBHsNbA7DI3GAyTm99zaDXuZAKH8v3RguWkiM2VN
         O8Dsh9usI3T/yE2EkNqqugvx8jvjzobjO/nB7gnEdHx/yu5aRGQcdD0AeSNUIp/aSDen
         9vumCnR7edk7ikFu/hN2Hh+FvUPRe1pyuErsY5RCsXrGChotXhedMRQvs40JUYlaraZ5
         F9XScVaUmh0fYe/+3a4CXqV9oq3/xYRRKXt2fmx4Q1VwzfaVBxzOQqjHcWWu02UHLlk9
         PiAy2iok3RqStX08WdMtoSC1p48s/Vbk8P4x1piGjzI1XmdTJfeikh1S9akIUxF6/AQR
         Dzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AvodmV6r1uh3+mDTSjqcwni55KL3aLeYcKEIfJZqDE=;
        b=aofra8EjPB8YCbxHLuSL5CQXb+128JZD+L8yHqRkHokrKYyBgu/9w/VF1VjBurY4lv
         iEbJ2foHouzx/9T7d2n5lQVRJUaW52aQcfr4CdkOHzpPWKNR0i+scxsBgE2sO+RTu1Lm
         UtrP4d8F8166QoBEJU4ZYwgc51Nwgc7D7xTlXHGyZotGXNoudpc4ZRActvO/Az0768KK
         8HfGt8ivS9N+v4UD96F0QkJA5rsJKM5t69Xf1nDoREFiDTQ2HsNfJWJs9qrWy+BVr2pQ
         QA91j2Tny7AT54brhgGZWb9RNfIkDnjUJ3uUjPlIhWeMh4hrMBnYytUDi/LRJcDcQzOg
         qMkQ==
X-Gm-Message-State: AFqh2kpAOt2sGDcDkV4+O0zkqfOOZ7SNIoLTsXm3VKgmsy33zmdxDMQZ
        zROUQiSXrMyoX9d7FaYYtVo=
X-Google-Smtp-Source: AMrXdXtj04V3806l2QPVJaWXM7VUg6xGiaQKAUFgAllga04EF7x+JJXdvpI0wO3L/6yA0drrLYtVXA==
X-Received: by 2002:a19:f513:0:b0:4b5:731f:935a with SMTP id j19-20020a19f513000000b004b5731f935amr3431318lfb.0.1672999849781;
        Fri, 06 Jan 2023 02:10:49 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b004b5adb59ed5sm100351lfr.297.2023.01.06.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:10:49 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:10:47 +0200
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>
Subject: Re: [PATCH v2 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20230106121047.00003048@gmail.com>
In-Reply-To: <SA1PR21MB133576523E55BBC7300DE2B1BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-3-decui@microsoft.com>
        <20230105114435.000078e4@gmail.com>
        <SA1PR21MB133560538DDD7006CCB36E30BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
        <20230105201024.00001ea0@gmail.com>
        <SA1PR21MB133576523E55BBC7300DE2B1BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 5 Jan 2023 20:29:25 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Zhi Wang <zhi.wang.linux@gmail.com>
> > Sent: Thursday, January 5, 2023 10:10 AM
> > [...]
> > I see. Then do we still need the hv_map_memory()in the following
> > code piece in netvsc.c after {set_memoery_encrypted, decrypted}()
> > supporting memory from vmalloc()?
> 
> For SNP, set_memory_decrypted() is already able to support memory
> from vmalloc().
> 
> For TDX, currently set_memory_decrypted()() is unable to support
> memory from vmalloc().
> 
I guess we both agree that memory conversion in HV should be done through
coco so the hv_map_memory can be removed (even the extra does not hurt
currently)

The memory conversion in current HV code is done by different approaches.
Some are going through the coco, some are not, which ends up
with if(hv_isolation_type_snp()) in memory allocation path. It can be
confusing. I suppose a reasonable purpose of hv_isolation_type_snp()
should cover the AMD SEV-SNP specific parts which haven't been (or are
not going to be) covered by coco. For example the GHCB stuff. 

Thanks,
Zhi.

> >         /* set_memory_decrypted() is called here. */
> >         ret = vmbus_establish_gpadl(device->channel,
> > net_device->recv_buf, buf_size, 
> > &net_device->recv_buf_gpadl_handle);
> >         if (ret != 0) {
> >                 netdev_err(ndev,
> >                         "unable to establish receive buffer's
> > gpadl\n"); goto cleanup;
> >         }
> > 
> >         /* Should we remove this? */
> 
> The below block of code is for SNP rather than TDX, so it has nothing to
> do with the patch here. BTW, the code is ineeded removed in Michael's
> patchset, which is for device assignment support for SNP guests on
> Hyper-V:
> https://lwn.net/ml/linux-kernel/1669951831-4180-11-git-send-email-mikelley@microsoft.com/

So happy to see this. :)

> and I'm happy with the removal of the code.
> 
> >         if (hv_isolation_type_snp()) {
> >                 vaddr = hv_map_memory(net_device->recv_buf, buf_size);
> >                 if (!vaddr) {
> >                         ret = -ENOMEM;
> >                         goto cleanup;
> >                 }
> > 
> >                 net_device->recv_original_buf = net_device->recv_buf;
> >                 net_device->recv_buf = vaddr;
> >         }
> > 
> > I assume that we need an VA mapped to a shared GPA here.
> 
> Yes.
> 
> > The VA(net_device->recv_buf) has been associated with a shared GPA in
> > set_memory_decrypted() by adjusting the kernel page table.
> 
> For a SNP guest with pavavisor on Hyper-V, this is not true in the
> current mainline kernel: see set_memory_decrypted() ->
> __set_memory_enc_dec():
> 
> static int __set_memory_enc_dec(unsigned long addr, int numpages, bool
> enc) {
> 		//Dexuan: For a SNP guest with paravisor on Hyper-V,
> currently we // only call hv_set_mem_host_visibility(), i.e. the page
> tabe is not // updated. This is being changed by Michael's patchset,
> e.g.,
> https://lwn.net/ml/linux-kernel/1669951831-4180-7-git-send-email-mikelley@microsoft.com/ 
>         if (hv_is_isolation_supported())
>                 return hv_set_mem_host_visibility(addr, numpages, !enc);
> 
>         if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>                 return __set_memory_enc_pgtable(addr, numpages, enc);
> 
>         return 0;
> }
> 
> > hv_map_memory()
> > is with similar purpose but just a different way:
> > 
> > void *hv_map_memory(void *addr, unsigned long size)
> > {
> >         unsigned long *pfns = kcalloc(size / PAGE_SIZE,
> >                                       sizeof(unsigned long),
> > GFP_KERNEL);
> >         void *vaddr;
> >         int i;
> > 
> >         if (!pfns)
> >                 return NULL;
> > 
> >         for (i = 0; i < size / PAGE_SIZE; i++)
> >                 pfns[i] = vmalloc_to_pfn(addr + i * PAGE_SIZE) +
> >                         (ms_hyperv.shared_gpa_boundary >>
> > PAGE_SHIFT);
> > 
> >         vaddr = vmap_pfn(pfns, size / PAGE_SIZE, PAGE_KERNEL_IO);
> >         kfree(pfns);
> > 
> >         return vaddr;
> > }

