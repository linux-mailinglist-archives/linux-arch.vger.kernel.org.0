Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53805E2DE6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfJXJvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 05:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfJXJvH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 05:51:07 -0400
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A218C20856;
        Thu, 24 Oct 2019 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571910666;
        bh=/+Ql7TLHSuqRBTRatle/8UuavLp8M4wg90FkQYvX1ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHWraPApPelpUnhz80IdJ6qZ3Jw5R++RrLd4l7PfuOCafzao2ErCM/1ApQ91lUK7E
         0uYS2e9f/H3CF0FLyqr+11wZLk0ellanlE4rDMkvpBd62/g9WmtWFtWw6GDYvxb0sb
         DxnPSUgn8n7OenmDPbNDDb0vZF9lfVpAL0VLc18U=
Date:   Thu, 24 Oct 2019 12:50:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "richard@nod.at" <richard@nod.at>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-ID: <20191024095053.GC12281@rapoport-lnx>
References: <1571822941-29776-9-git-send-email-rppt@kernel.org>
 <20191024093451.15161-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024093451.15161-1-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 24, 2019 at 09:35:12AM +0000, Peter Rosin wrote:
> On 2019-10-23 12:28, Mike Rapoport <rppt@kernel.org> wrote:
> > parisc has two or three levels of page tables and can use appropriate
> > pgtable-nopXd and folding of the upper layers.
> >
> > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > definitions of __PAGETABLE_PxD_FOLDED in parisc with
> > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > include/asm-generic/pgtable-nopmd.h for three-lelve configurations and
> 
> I think you mean .../pgtable-nopud.h in the latter case.

Right, thanks!
 
> Cheers,
> Peter

-- 
Sincerely yours,
Mike.
