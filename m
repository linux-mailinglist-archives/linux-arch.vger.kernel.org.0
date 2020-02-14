Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9499515D38D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgBNIMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 03:12:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34963 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgBNIMX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 03:12:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so9581012wmb.0;
        Fri, 14 Feb 2020 00:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+whp3SRlB3fcTDZeactPintXvEpOGniGrr5mWYhRNY=;
        b=tj2Myhm/kLBda1uCPkEcFyxgHOGUbf9nPC1yRk/wUGuz3xW2N2cp/BOztmVEpms2Iw
         Es2XmgXYlQlpR8cCq/qJGJqbaS2YJGjLERM0Wp8vKGgBVWV77Wkp0NuImZkCNd1y2cNc
         VDOYA9dGfR+XSLecDu2M4nV4E53S5K1IP49BAvuslw2NJftNUCs23UVi5KEvgJcbzniq
         cnI9gau1+0Zot2mJr4sMXgifFoqX/EmzWuJ6aR/HcS1jauqY1emNNQm0tXqcPkHtPNYQ
         5+A8eAPKOW7NxdilnDZVvwb9Wruj8vFilFKX78eOCr0upl4xY6RURct1ehT493Q0jjV6
         tRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+whp3SRlB3fcTDZeactPintXvEpOGniGrr5mWYhRNY=;
        b=US8s8+Qw9MQ4Q3KYKfXED1XDpOr0Jq3lRm1+698XckKfyFLXknrhCiEbsMY7G9N9zt
         kmxsYMGUyjs3gzW1HHXcxkMwPZ6NwyvaxZY2JmX9F3Xt6ubG5afHdrX1/5Rv1IRIuVT3
         Wg+yGRWTd+NVEpxvqso7rGso9gg2FpihKMELMJTwP5bDg7LAJL/KpyfJQrvSNOnyGgrq
         x7zPiT2ZvcCAu+Ngx6MdNsC+ADpuGvOfBKjk/Xex2U6qNhB6B/bt5UeT7VkDoOXhkzUE
         lrdKApJfbTLei9YYkf4fC2zt9a1p0hprez8ZvT0ea8JzT/+stnknHBu1vlKQwPQYJZR9
         Htvg==
X-Gm-Message-State: APjAAAUyKuO2WwCFjIuqZntxXyH1fz5eUwN2XkgSAkMHsNRdCmftL/xC
        l3s5sjfieGwISL+kyzFohuA=
X-Google-Smtp-Source: APXvYqyrxrWm6rhJSwzRVJAsMRHqTij9c7qVsUL/yEXgQ9HFAOZxBfWRBLF6+bXWF7lsU2vFs11LmA==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr3191543wmi.104.1581667940936;
        Fri, 14 Feb 2020 00:12:20 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id x10sm5847657wrv.60.2020.02.14.00.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:12:20 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:12:13 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200214081213.GA17708@andrea>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-3-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> @@ -0,0 +1,24 @@
> +C Atomic-set-observable-to-RMW
> +
> +(*
> + * Result: Never
> + *
> + * Test of the result of atomic_set() must be observable to atomic RMWs.
> + *)
> +
> +{
> +	atomic_t v = ATOMIC_INIT(1);
> +}
> +
> +P0(atomic_t *v)
> +{
> +	(void)atomic_add_unless(v,1,0);

We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
entry (6b) in tools/memory-model/README; the discussion was here:

  https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com

but unfortunately I can't remember other details at the moment: maybe
it is just a matter of or the proper time to update that section.

Thanks,
  Andrea
