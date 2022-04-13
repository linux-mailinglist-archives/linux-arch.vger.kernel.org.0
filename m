Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1CB4FF515
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiDMKu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 06:50:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49988 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiDMKu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 06:50:59 -0400
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 8D09684090C3;
        Wed, 13 Apr 2022 03:48:36 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:48:31 +0100 (BST)
Message-Id: <20220413.114831.840569799075069520.davem@davemloft.net>
To:     anshuman.khandual@arm.com
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        hch@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        khalid.aziz@oracle.com
Subject: Re: [PATCH V5 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20220412043848.80464-5-anshuman.khandual@arm.com>
References: <20220412043848.80464-1-anshuman.khandual@arm.com>
        <20220412043848.80464-5-anshuman.khandual@arm.com>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 13 Apr 2022 03:48:39 -0700 (PDT)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Tue, 12 Apr 2022 10:08:45 +0530

> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. It localizes arch_vm_get_page_prot()
> as sparc_vm_get_page_prot() and moves near vm_get_page_prot().
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
