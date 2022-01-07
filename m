Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0EB487AD2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiAGQ6C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jan 2022 11:58:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4372 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiAGQ6B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 11:58:01 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVq6700Cbz67Nt8;
        Sat,  8 Jan 2022 00:53:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 17:57:59 +0100
Received: from [10.47.89.210] (10.47.89.210) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 16:57:58 +0000
Subject: Re: [RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-csky@vger.kernel.org>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <00c5a9e2-1876-e8d1-68f3-2be6d3bd38cb@huawei.com>
 <64d4b0d66379affd59c5a24ddb71a8f208330362.camel@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <38c595ea-f2fb-db54-397b-41c67fa59208@huawei.com>
Date:   Fri, 7 Jan 2022 16:57:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <64d4b0d66379affd59c5a24ddb71a8f208330362.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.210]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/01/2022 07:21, Niklas Schnelle wrote:
> I checked again by adding
> 
> config HAS_IOPORT
>         def_bool n
> 
> in arch/s390/Kconfig and that doesn't seem to make a difference,
> allyesconfig builds all the same. Also checked for CONFIG_HAS_IOPORT in
> my .config and that isn't listed with or without the above addition.

Strange, as I build your branch and I see it:

HEAD is now at 9f421b6580ed asm-generic/io.h: drop inb() etc for 
HAS_IOPORT=n
john@localhost:~/kernel-dev5> export ARCH=s390
john@localhost:~/kernel-dev5> export 
CROSS_COMPILE=/usr/bin/s390x-suse-linux-
john@localhost:~/kernel-dev5> make allyesconfig
#
# configuration written to .config
#
john@localhost:~/kernel-dev5> more .config | grep HAS_IOPORT
CONFIG_HAS_IOPORT=y

> 
> I think this is because without a help text there is no "config
> question" and thus nothing that allyesconfig would set to yes. I do
> agree though that it's better to be explicit and add the above to those
> Kconfigs that don't support HAS_IOPORT.

So maybe something like:
config HAS_IOPORT
	def_bool ISA || LEGACY_PCI
	depends on !S390

Otherwise you can build inb et al from asm-generic/io.h and get the 
original compile error about arithmetic on NULL pointer, right?

But I assume that there is a more elegant way of doing this...

Thanks,
John


