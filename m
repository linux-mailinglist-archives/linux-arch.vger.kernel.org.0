Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82752C873E
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgK3O6e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 09:58:34 -0500
Received: from mail.efficios.com ([167.114.26.124]:35268 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgK3O6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 09:58:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E859C2E742B;
        Mon, 30 Nov 2020 09:57:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WPj8ra9yj3oq; Mon, 30 Nov 2020 09:57:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B1B292E73CB;
        Mon, 30 Nov 2020 09:57:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B1B292E73CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606748272;
        bh=lITSvOLPDJvy5RUmpU0kdOKisZq6vOXOt1kVNAyT3Ok=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HmlyKAGOiYSSOHLNc5JretHxBI3AFVQ3Vu0Z+ZtqcifiILIl+Un7HehB0UJxNYoc8
         qSYdQ2wbu6DceimCyu1SLO5EkMuE3g1sY81IygmeC1Xp6EeMTGGc2Vz+CGwSQ2FVvh
         rt592i6qwFQXtxEiejsOUt/3TY0gOVP8IhrDYntlbWJqHr5k4SBp+WgIPgq4rFIp13
         fhoM0u+IR1Rhv64x1lLVbqnHItGxrgzjG/02v4ZERSYU5mezsc/kcnztC1DRRY5FIw
         k6gzfH+eV+tkvtCBKdZygOHbLmvY5z5E73GmYgQBqasXlucIy+ymbJHzlNTXF9APje
         u+xoQ8g37l/Ew==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j89H0hvMPN_8; Mon, 30 Nov 2020 09:57:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A404D2E749F;
        Mon, 30 Nov 2020 09:57:52 -0500 (EST)
Date:   Mon, 30 Nov 2020 09:57:52 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mm <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Message-ID: <274632921.67676.1606748272576.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201128160141.1003903-3-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-3-npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: c4mu60IGczpdvtSKpGMZAdba0/GKbQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Nov 28, 2020, at 11:01 AM, Nicholas Piggin npiggin@gmail.com wrote:

> And get rid of the generic sync_core_before_usermode facility. This is
> functionally a no-op in the core scheduler code, but it also catches

This sentence is incomplete.

> 
> This helper is the wrong way around I think. The idea that membarrier
> state requires a core sync before returning to user is the easy one
> that does not need hiding behind membarrier calls. The gap in core
> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
> tricky detail that is better put in x86 lazy tlb code.

Ideally yes this complexity should sit within the x86 architecture code
if only that architecture requires it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
