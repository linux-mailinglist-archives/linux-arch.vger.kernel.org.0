Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053503D7981
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhG0PP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhG0PP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 11:15:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97FC061757;
        Tue, 27 Jul 2021 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4JdE/aW6odLJdtfdNjxa/S0U0ePQHRA8MXvplpff6bM=; b=dBVptD61D5ANUSUouTM0t/zwCr
        hQb89/AeDjkTjJ62t5BB3e6J9KJ5f1cTMzIrf1ugfiCbudRMBVEOgweNq2oME/ThYwLnwq95hjCwP
        cfLhsa5xuolDjO3WxLHM7i8cVYScLHXI72C21lVChwvGg0dbnLkLk0aOkiXHG9H8xaeTXqK6iju+6
        37pNYEiAG/RJUsfl05zRYM3mjjLrPEYwrnD1VAVA5AL2hCrdaXxNARoR7CRRNcItBSDq+juzm/WHD
        mKOtTTAUmKuJGVMSpV0woMW7rbZo+g3TZvDNpRhhupubuqvfyAbaxq+gdWiEHwin800v0Aob1T4VL
        mxOSBJfA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8OiU-00F89m-Un; Tue, 27 Jul 2021 15:10:39 +0000
Date:   Tue, 27 Jul 2021 16:09:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 6/6] arch: remove compat_alloc_user_space
Message-ID: <YQAhxgdPHt8xndEM@infradead.org>
References: <20210727144859.4150043-1-arnd@kernel.org>
 <20210727144859.4150043-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727144859.4150043-7-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

finally!

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
