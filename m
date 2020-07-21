Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7043A22819C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgGUOE4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgGUOE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:04:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1DEC061794;
        Tue, 21 Jul 2020 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35SbtfWGz45hL6nU4tFXWLRurwYHBqmeuQ1Pfog9lBE=; b=0vFJ01JML6wAxqx0pgoErHwFWm
        qgYuA1U50+QuNkCwa4AAwpV95tjuDr4qpsWJTXWQgdrh2sg3jeCzWLEri5cWOm0pdYjjBVdOLNkWU
        W71JJO0GypwD9MgwhTFgGGTvtW87X5kKZ2pPqc998yJkhTfzsqXJtkOSk4v+XnDqeS+F3v5zQPWMM
        kA9oc3/BmPxl+U81YAt+TcQrP8352Pt3dTI32jB+evjClILufPhW9gV0QEd/H/WroCoqIJh48OLPh
        uxqV4uWPVIfETObbKHS8nHPPnfcWL/VKLoKXszfRorLG33+LEZ2LP9v3vtqV8s4btah6+p23tnc2R
        ECB9q1WQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxssz-0007zy-LP; Tue, 21 Jul 2020 14:04:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E0A6304D28;
        Tue, 21 Jul 2020 16:04:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1603B20DCCA0B; Tue, 21 Jul 2020 16:04:48 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:04:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/8] objtool, kcsan: Add __tsan_read_write to uaccess
 whitelist
Message-ID: <20200721140448.GZ10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-3-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:10PM +0200, Marco Elver wrote:
> Adds the new __tsan_read_write compound instrumentation to objtool's
> uaccess whitelist.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 63d8b630c67a..38d82e705c93 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
>  	"__tsan_write4",
>  	"__tsan_write8",
>  	"__tsan_write16",
> +	"__tsan_read_write1",
> +	"__tsan_read_write2",
> +	"__tsan_read_write4",
> +	"__tsan_read_write8",
> +	"__tsan_read_write16",
>  	"__tsan_atomic8_load",
>  	"__tsan_atomic16_load",
>  	"__tsan_atomic32_load",
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
