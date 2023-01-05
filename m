Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5265F384
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 19:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAESKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 13:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjAESK3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 13:10:29 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67734289;
        Thu,  5 Jan 2023 10:10:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x37so32552329ljq.1;
        Thu, 05 Jan 2023 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f7l4j2UrPllEPm8+N2nXwOp9iXAGfz91k1xXgPf6Kk=;
        b=mSMnFW6xoZovdcX7os6aKr731GddHQa6xuVIe1FgODpLpgTUsxpmRkrkzLsO394xNB
         SwpWUYEV4FZbJmJnis5ViGM4no3lRAcPkhB+FKtSHwF4SGzVT7VgRgdi+8w09kyG+a0A
         UUqDobo4tCUWHDxZAXMjc3C+EFKQsnHZnCm2JPReMpCUHOtFMW3Zaie7MU3kbcq6ih4G
         KX9z2BT1H64wTFAkkNCc8yYufJ6J1LnSlDxmmPaMFhFNQa17f57c6vMXbG2QIpBump6/
         ghtPtOfX64MYueZwJypTGXO8197r9AhPlz7M4we+Er8uvOFfZer+j/4EttaCmkgltyuy
         dubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f7l4j2UrPllEPm8+N2nXwOp9iXAGfz91k1xXgPf6Kk=;
        b=BgfcRmyNBmPckHwwKHl7tbIeMOwJmXUhK66KyoIEtudBKowi+Cf6urS9iM3Ws60liD
         ES9keqz97ScwbGIK7zYoxOqrYvG8rPG6jHhZl0f6zh52x6aE5ONV6Slv6jrvI25/no5o
         v3jrxxzv2jiQnSF6XBau9QoDhSSafGDUMmKWy1hKIznrGyjhS2IlstUyowSldkDJTDqF
         S/tUFQ+srWoR/spOVLi3o3njENG6Vp3rrGKDLQaj+arAgc9Y/BCToptF9UuDoyGXFukL
         8ycsV8H9JZjqiFcRVOuGnZCF9KkveUluW7LLKaTwp6kuum/RCbvvnHVxxvwJ0rNepO9G
         MvMQ==
X-Gm-Message-State: AFqh2kqQ5/jeuK0eqgmODGYDhvCbrgop/WpRD36VDDt4oMXtLS3pAQxN
        N1Ml1ND0W3x7lgUduxVXY9w=
X-Google-Smtp-Source: AMrXdXtT+HwQHyFsEtfj1vuIuO9LhJP8T6Ca+qbI9B91foM4ykB3ysSwqn+wyeegawwQcPhIgrdhKA==
X-Received: by 2002:a05:651c:1593:b0:277:a4b:56c9 with SMTP id h19-20020a05651c159300b002770a4b56c9mr3407707ljq.0.1672942226284;
        Thu, 05 Jan 2023 10:10:26 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id f2-20020a05651c02c200b0027fc4f018a8sm2852020ljo.5.2023.01.05.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:10:26 -0800 (PST)
Date:   Thu, 5 Jan 2023 20:10:24 +0200
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
Message-ID: <20230105201024.00001ea0@gmail.com>
In-Reply-To: <SA1PR21MB133560538DDD7006CCB36E30BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-3-decui@microsoft.com>
        <20230105114435.000078e4@gmail.com>
        <SA1PR21MB133560538DDD7006CCB36E30BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
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

On Thu, 5 Jan 2023 17:33:16 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Zhi Wang <zhi.wang.linux@gmail.com>
> > Sent: Thursday, January 5, 2023 1:45 AM
> >  [...]
> > On Tue,  6 Dec 2022 16:33:21 -0800
> > Dexuan Cui <decui@microsoft.com> wrote:
> > 
> > > When a TDX guest runs on Hyper-V, the hv_netvsc driver's
> > > netvsc_init_buf() allocates buffers using vzalloc(), and needs to
> > > share the buffers with the host OS by calling
> > > set_memory_decrypted(), which is not working for vmalloc() yet. Add
> > > the support by handling the pages one by one.
> > 
> > It seems calling set_memory_decrypted() in netvsc_init_buf() is
> > missing in this patch series. I guess there should be another one
> > extra patch to cover that.
> 
> set_memory_decrypted() is not missing here. In netvsc_init_buf(), after
> the line "net_device->recv_buf = vzalloc(buf_size);", we have 
> 
> vmbus_establish_gpadl(device->channel, net_device->recv_buf, ...), which
> 
> calls __vmbus_establish_gpadl(), which calls 
> 
> set_memory_decrypted((unsigned long)kbuffer, ...)
> 

I see. Then do we still need the hv_map_memory()in the following
code piece in netvsc.c after {set_memoery_encrypted, decrypted}()
supporting memory from vmalloc()?

	/* set_memory_decrypted() is called here. */

        ret = vmbus_establish_gpadl(device->channel, net_device->recv_buf,
                                    buf_size,
                                    &net_device->recv_buf_gpadl_handle);
        if (ret != 0) {
                netdev_err(ndev,
                        "unable to establish receive buffer's gpadl\n");
                goto cleanup;
        }
	
	/* Should we remove this? */
        if (hv_isolation_type_snp()) {
                vaddr = hv_map_memory(net_device->recv_buf, buf_size);
                if (!vaddr) {
                        ret = -ENOMEM;
                        goto cleanup;
                }

                net_device->recv_original_buf = net_device->recv_buf;
                net_device->recv_buf = vaddr;
        }

I assume that we need an VA mapped to a shared GPA here.

The VA(net_device->recv_buf) has been associated with a shared GPA in
set_memory_decrypted() by adjusting the kernel page table. hv_map_memory()
is with similar purpose but just a different way:

void *hv_map_memory(void *addr, unsigned long size)
{
        unsigned long *pfns = kcalloc(size / PAGE_SIZE,
                                      sizeof(unsigned long), GFP_KERNEL);
        void *vaddr;
        int i;

        if (!pfns)
                return NULL;

        for (i = 0; i < size / PAGE_SIZE; i++)
                pfns[i] = vmalloc_to_pfn(addr + i * PAGE_SIZE) +
                        (ms_hyperv.shared_gpa_boundary >> PAGE_SHIFT);

        vaddr = vmap_pfn(pfns, size / PAGE_SIZE, PAGE_KERNEL_IO);
        kfree(pfns);

        return vaddr;
}
