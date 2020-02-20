Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3F165A00
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBTJTa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 04:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTJTa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 04:19:30 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692E424654;
        Thu, 20 Feb 2020 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582190369;
        bh=odg0Ls4Jo2/nIPx4hfbXC/I9JWJmXoZHtSAzcHL2wmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNwjx4/Js/7Z9lzy5NCgL0+In+nXgsvXnhURb15Ogtuubx6XOD5dHquCYbTWkgxWr
         JrU2U6WdM/qI/f1kcvCxCCM+oAy17L1hcbAkX+WEdAl+djf5QKH3896aaloijVTOn8
         KiaLTEJWAraqhlFEjS05Jag6VUFWWS4KpiHy8Atg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j4hzT-006h0X-K0; Thu, 20 Feb 2020 09:19:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Feb 2020 09:19:27 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
In-Reply-To: <20200219150744.428764577@infradead.org>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
Message-ID: <9af753c4d91f6a46d3121e72186cee03@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, will@kernel.org, mpe@ellerman.id.au, pmladek@suse.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-02-19 14:47, Peter Zijlstra wrote:
> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for cleaning this up!

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
