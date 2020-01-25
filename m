Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30864149534
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAYLYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 06:24:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 06:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PhH/Bei9yqMj6egnkFuJIFtrTs5hg8forCAjWaNH6eQ=; b=lZpV46ccENddjfWybH99y/x/yc
        TzsfYeADsfzrDY5l0QKM6D3J6I9x7tbfdn1c/tHMcTCzoW77CcAcKeIJnm/9R56lJZGLtf8Yt5yDz
        G9+3pDPOD2At24Tb+QeqY7xjCk3+b2fwYSV11OJA9NjYipT2ES/AStvYIjbcNQaohmtSv+JRiy5TO
        sFSBSd3b2qhqIl9wZJjdgh70DmrIP3oDzig+3YOW9b9di1vzjGVw192a9O93hwqROj2KYdIWlpPNv
        NFRbzGsokvvEsopCwu6xmAmlKRy4eTqRIJm62+tUMHhE7c261ZjmYL0as88zVFECz3EJe/o8eeKhL
        ba6hJiyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivJXU-00050c-0N; Sat, 25 Jan 2020 11:23:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67911980BB0; Sat, 25 Jan 2020 12:23:41 +0100 (CET)
Date:   Sat, 25 Jan 2020 12:23:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com,
        Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v7 1/5] locking/qspinlock: Rename mcs lock/unlock macros
 and make them more generic
Message-ID: <20200125112341.GY11457@worktop.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-2-alex.kogan@oracle.com>
 <20200122091547.GU14879@hirez.programming.kicks-ass.net>
 <C608A39E-CAFC-4C79-9EB6-3DFD9621E3F6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C608A39E-CAFC-4C79-9EB6-3DFD9621E3F6@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 06:51:11PM -0500, Alex Kogan wrote:
> > On Jan 22, 2020, at 4:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Also, pass_lock seems unfortunately named…

> Well, I know the guy who should be blamed for that one :)
> https://lkml.org/lkml/2019/7/16/212 <https://lkml.org/lkml/2019/7/16/212>

Ha, yes, that guy is an idiot sometimes ;-)

