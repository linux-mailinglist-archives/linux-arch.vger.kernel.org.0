Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CC16B791
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 03:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgBYCMW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 21:12:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41586 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgBYCMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 21:12:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id b5so3491520qkh.8
        for <linux-arch@vger.kernel.org>; Mon, 24 Feb 2020 18:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aV1wtzsixyxbIlgwZVMjWFxlrGFi0X1sLLQ6AvkFw1M=;
        b=Jk1CqHzQBnOMrF2X0s+N5OdS4ebnoq+q2+n71ELYrkrblxYD9qjWtUaZmVOHPduZuI
         1L5Va9/zeze48RCRMN+cfSWsT025ckOaGJcLgdDarI76+j27MlzRzUgRajMIR4ctLzy+
         QqWW4Tq+WqrKM0qSiXYwvYW+auRw5ETve76eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aV1wtzsixyxbIlgwZVMjWFxlrGFi0X1sLLQ6AvkFw1M=;
        b=bzvcYVFwBAOeieTom5Taeo+aC9HKu6uFx1k2vmDQwFuZLmTgAA82reH7lVQyaHCxWW
         qaNW7QkB5CJAH6r9BiCJzb75rA9jljpMjnlm5Ez6ETlb9WrhDpiBo74uoLEsic+N61lU
         3AWEEEkoxdd8JGEHosTruRgn+nyhHB8lv1VJ+zDl1LpVVvuGqF0XR+TddZdlRpe4w9fe
         3BC8rZlq5Ji8w94Qh6gNpetoY3ciw56+Og26Ft4N8BMLoOik5QCLP7hfEWog+TKym5J+
         haeM6heKg3n+s2ldoBKxhP4zp4TTcfJIbobcUEjQlLP3d8llMfus5dKSmACuSDAih0L6
         520A==
X-Gm-Message-State: APjAAAV6D7SL3GzCHPu5qzN2dbVUzQspzsqfW68qPJEWS3tKA2ZJA5jp
        o1In7HA8zPh1+ev/s8oNuKQZxA==
X-Google-Smtp-Source: APXvYqxAJO1y+PRZqaNlPLjpP+h9ynxxQ1fDyUoGCsEl+wBDpiS2urRyLKsL3UMT7hyRdnrkk9GNJw==
X-Received: by 2002:a37:c07:: with SMTP id 7mr53621921qkm.414.1582596741329;
        Mon, 24 Feb 2020 18:12:21 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v7sm6856624qkg.103.2020.02.24.18.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 18:12:20 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:12:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Message-ID: <20200225021220.GD253171@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200222030843.GA191380@google.com>
 <20200224101050.GE14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224101050.GE14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 11:10:50AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 10:08:43PM -0500, Joel Fernandes wrote:
> > On Fri, Feb 21, 2020 at 02:34:17PM +0100, Peter Zijlstra wrote:
> > > nmi_enter() does lockdep_off() and hence lockdep ignores everything.
> > > 
> > > And NMI context makes it impossible to do full IN-NMI tracking like we
> > > do IN-HARDIRQ, that could result in graph_lock recursion.
> > 
> > The patch makes sense to me.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > NOTE:
> > Also, I was wondering if we can detect the graph_lock recursion case and
> > avoid doing anything bad, that way we enable more of the lockdep
> > functionality for NMI where possible. Not sure if the suggestion makes sense
> > though!
> 
> Yeah, I considered playing trylock games, but figured I shouldn't make
> it more complicated that it needs to be.

Yes, I agree with you. Thanks.

 - Joel

