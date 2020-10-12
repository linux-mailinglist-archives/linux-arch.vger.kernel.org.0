Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7228BD94
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgJLQZa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390420AbgJLQZa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 12:25:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD3C0613D0;
        Mon, 12 Oct 2020 09:25:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dn5so17603366edb.10;
        Mon, 12 Oct 2020 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pXnKCzWlycdnJfAJsoMlDKin2LVR9i0PPejrjR/dATY=;
        b=rJB4vOGQ5Txj0jSdSXiPQKtk2ctrB9lcGAj+bQmxUcYQHIEcmfAyEO5hUPnV6kTvuB
         TGx699EWJmPnbhJysZCO8JUUq9m2KbyVXLKc9xSrcUepB86sq4QdA57Y4f06QqSfZYWB
         vVVs1CjKMTLuVa4acFmH3MSH3sjbsjo+4/S/LgITXdycOEs7mQl9pIXdniS7hNXNeXqJ
         msgCoES4i5TGjLG5myOYs4YB3TQkQ0nk28mhSJi8mXLTrgOjTbp25wwjSttyxE6MKlSg
         SXgTlnirTP/JrkqTJaP3O5MRxKNJY2EoTbkFeXSFQjT2RC/war7TurEmF8eKK7RQHwqz
         HKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pXnKCzWlycdnJfAJsoMlDKin2LVR9i0PPejrjR/dATY=;
        b=pIvvqV16JF6Rja+Svq6/+ikxq76l8Cj5xtscgbYFSEHeBA/oXMT203fGyfxvXStkii
         Cic5BQPKLygDvYWgxFAd+Xfr/7s8fQV1pOCS8wUyG97Yi2R0uvOLspE2mfUek2RkhGN5
         Ovm7H/6tYENSuC1d2EJVUtlAAGNDXiYs9zq+fwGTU7Iom/VWKc+4lb04ldB5h/JHTodn
         DKN7Qjbcu0apSgiAoT5szJtK0sYiRn/BXtOJVfMt6yD1bGgtFhlgdjwD/sGCjFNxCF7s
         /zltoRZIHx/yf9ge3L7zTj6uGLrhWWuW4IV3gCjTDxGPjToVUIAc7rDPyQdBI1yQey69
         8f0Q==
X-Gm-Message-State: AOAM532SJZQiTtcvFORF3jnAqslNj4ae7oKwoxeoUkV4TYLek7dm+W40
        PuJWcVCx+GRQ/oFTqR14cEU=
X-Google-Smtp-Source: ABdhPJxUrBRGIHn+R31lvsWajGgryxHHFmrLEReFiTlJ4LUctHlT7QgptLY3CbpY8hHle2l5/1q+ig==
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr15049308edu.295.1602519929248;
        Mon, 12 Oct 2020 09:25:29 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id sd18sm10752597ejb.24.2020.10.12.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:25:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 18:25:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v5 19/21] asm-generic/atomic: Add try_cmpxchg() fallbacks
Message-ID: <20201012162526.GB3687261@gmail.com>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <159870621515.1229682.15506193091065001742.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159870621515.1229682.15506193091065001742.stgit@devnote2>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Only x86 provides try_cmpxchg() outside of the atomic_t interfaces,
> provide generic fallbacks to create this interface from the widely
> available cmpxchg() function.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Will Deacon <will@kernel.org>

Your SOB was missing here too.

Thanks,

	Ingo
