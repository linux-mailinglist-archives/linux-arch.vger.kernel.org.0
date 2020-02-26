Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE351708E5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 20:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgBZT1E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 14:27:04 -0500
Received: from foss.arm.com ([217.140.110.172]:41800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgBZT1E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 14:27:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 522DD30E;
        Wed, 26 Feb 2020 11:27:03 -0800 (PST)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5A4A3F881;
        Wed, 26 Feb 2020 11:27:01 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:26:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] arm64: mte: Add specific SIGSEGV codes
Message-ID: <20200226192658.GA4109@mbp>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-10-catalin.marinas@arm.com>
 <874kvdxj73.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kvdxj73.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 01:05:52PM -0600, Eric W. Biederman wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > Add MTE-specific SIGSEGV codes to siginfo.h.
> >
> > Note that the for MTE we are reusing the same SPARC ADI codes because
> > the two functionalities are similar and they cannot coexist on the same
> > system.
> 
> Any chance you can move the v2 notes up into the description or
> otherwise fix it.  The description talks about reusing the ADI codes
> which is no longer happening.

Oh, I forgot to check the patch description. I will fix it.

> Otherwise the patch looks good.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks.

-- 
Catalin
