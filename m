Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A38C1FCA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfI3LJd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 07:09:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43612 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3LJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Sep 2019 07:09:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so8219150edl.10
        for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2019 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hoPRGHVbwreJaKuJTwMu/7M+v6vkzcXMl4wfx/l4eck=;
        b=Ila6+TGDovETpv53sOvQ2w517iJMEK2OyPuLBJdC84lAOrQaaRg7L2y+3nOZNiBUt3
         mFjXVUTl8C5XPk5VoHn1QgpZAUmS/WKIVsh6QwsC3xmNHmJdSdezRHkm2xpEgJbW+0LV
         4giPfze5ugsDvbN1ctarvpHVdm2s4iYBu8Qdwr9wtnBCy6NrLe3xZjTxT/wbl7Gda1eD
         ohtWPbeEf6oponrlUUny9k6gouA44jM1BA4f+nCvNHPM+jf00DRdA3CwzI8tchv4MyPy
         7wq4d+26j+mErCT44DF39giDowfgNSFIFjRYU7RjaBPvJN81mLFNu8i9ose03vg3fSOl
         044A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hoPRGHVbwreJaKuJTwMu/7M+v6vkzcXMl4wfx/l4eck=;
        b=Gp/6KBCLYLEhFkHr/OCsSxlfXzUDWD/QYUeL6AT9n5qkjhNMzmAkXUMU9RIN/YVL3F
         4zdhVQ8mGfbWacIaSoGTn9U7g255oxgl+aFJwQ/yHMu3FbjHnRmWTubSJKDcqOxaHvl7
         aBY89XbfJ+PerCqVkK/uM1qsIfeOqJsdrCsZ9YNVOcmH1yTcUaZb3WMzfVQ3H9UOv4OX
         SBSw7Ix1cBwsI15cuEWt9IGqLmkidJtdCHHPCwn9JDrHLv72vNt+dDH7QgvNrzZT2Opz
         bK/tVgymEhc5FzgOd9es5gdife3WnaEaBlZXaWYjjvwIoIJBrrZMh8V8mUlx+KRfU4Sg
         69Yg==
X-Gm-Message-State: APjAAAUdwodYNQBWIhCsStNzicpeY6DFd5yaKoDsJlSb/8Vs/nVpuLLn
        SwiesXftyvGoZZmz+c9NOqipiQ==
X-Google-Smtp-Source: APXvYqwJ5k7lQ3pCPgimrWcSKiti3KDcvVnrCKGQE+0+9kADA50ZcFoZz8cFJ7AyLCtn3uHIdpAVOA==
X-Received: by 2002:a17:906:c7d4:: with SMTP id dc20mr18745450ejb.235.1569841769833;
        Mon, 30 Sep 2019 04:09:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f6sm2370369edr.12.2019.09.30.04.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 04:09:28 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D09D41020E6; Mon, 30 Sep 2019 14:09:27 +0300 (+03)
Date:   Mon, 30 Sep 2019 14:09:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v4 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
Message-ID: <20190930110927.nanq2wynvfmq7dhc@box>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-4-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927234008.11513-4-leonardo@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 27, 2019 at 08:40:00PM -0300, Leonardo Bras wrote:
> As decribed, gup_pgd_range is a lockless pagetable walk. So, in order to
     ^ typo

-- 
 Kirill A. Shutemov
