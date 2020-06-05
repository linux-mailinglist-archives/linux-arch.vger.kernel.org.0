Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24041EF48D
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFEJq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 05:46:28 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:57802 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFEJq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jun 2020 05:46:28 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 05:46:27 EDT
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 074932632F;
        Fri,  5 Jun 2020 09:39:30 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 920AE3ECDF;
        Fri,  5 Jun 2020 11:39:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 714562A8B2;
        Fri,  5 Jun 2020 11:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1591349967;
        bh=Mc+KjRBNjHChZugfBRKNmW7QiUMUHq4bLRjFgN61C1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z8y/Uewab6ayLKQzwu/SmIq6I/LY0DlIitaA8ocevUcr8WvbeXSWqZL6D7TRws1t4
         EEKOfQ1RLAK2HeV4SbGuRRrlY4/Jn8eyUTqMtagZfnU4XpED/mwv5N1lJAmZk7ce76
         e7FU4X6b8svHI3WlBbGqetpBUuKygUFQJDnDK81E=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nqLx46V5Ntsd; Fri,  5 Jun 2020 11:39:26 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Fri,  5 Jun 2020 11:39:26 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 9A5CC40FC0;
        Fri,  5 Jun 2020 09:39:23 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="B5JBJHJG";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost (unknown [60.177.191.23])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 746EF40FC0;
        Fri,  5 Jun 2020 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
        s=default; t=1591349959;
        bh=Mc+KjRBNjHChZugfBRKNmW7QiUMUHq4bLRjFgN61C1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B5JBJHJGNTVBAPlWuCkYxb56+3QNYhdHNdSzlbJh4cA5HresEMMGXO+zn1lFR1vVp
         vSB0tSMniQIhftXQgt0NpzRV7O44txfV7cda/ePLSLWn++CrZ1IJ52nICGUnwv6Dmb
         4MNtOdZoO5T40dUwkN+Ed9YtX254a647/eiAl5Ec=
Date:   Fri, 5 Jun 2020 17:39:09 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] MIPS: set page access bit with pgprot on some MIPS
 platform
Message-ID: <20200605173909.000018ff@flygoat.com>
In-Reply-To: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A5CC40FC0
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[60.177.191.23:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[flygoat.com:+];
         DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
         RCPT_COUNT_SEVEN(0.00)[8];
         DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri,  5 Jun 2020 17:11:05 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On MIPS system which has rixi hardware bit, page access bit is not
> set in pgrot. For memory reading, there will be one page fault to
> allocate physical page; however valid bit is not set, there will
> be the second fast tlb-miss fault handling to set valid/access bit.
> 
> This patch set page access/valid bit with pgrot if there is reading
> access privilege. It will reduce one tlb-miss handling for memory
> reading access.
> 
> The valid/access bit will be cleared in order to track memory
> accessing activity. If the page is accessed, tlb-miss fast handling
> will set valid/access bit, pte_sw_mkyoung is not necessary in slow
> page fault path. This patch removes pte_sw_mkyoung function which
> is defined as empty function except MIPS system.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---

Thanks for tracking it down.

Could you please make the patch tittle more clear?
"Some" looks confuse to me, "systems with RIXI" would be better.

- Jiaxun
