Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93C76D0E20
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC3SxE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC3SxE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 14:53:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A691EB6D;
        Thu, 30 Mar 2023 11:52:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A267A733;
        Thu, 30 Mar 2023 18:52:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A267A733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680202361; bh=wg7OMp22RDcyo//HBDrXS4XZAIraWO+qV5yrMrn+nVs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MXklz7tGfEWzk+yrrfjZmgjKxua8EpWUwK7hX4N9XaKfDQT77bh/3d5wC5Mh1KQtt
         gnpaQu6wqHIIdUtlwZHQ+sXGUSUjZ7img3+9OatvW5eIHNaD26Gu3ETEQIMUjqrLg/
         iMMYhgK6Wq0o/PhHXeG35HQtkQN33JDGmuf2BVKWDvsu7l9cXgHvEFEFXWTHNnEFQK
         Rvxj9HhE+nmOlRBQf7jaE5kxFwGd4+R/+PtVmZtz1WzGrz5pnSWIsG0VJwSfwkym+g
         QDYXjJx53D1IDAL76Nh1WJRZKideTzsZganlMJ+BLZn5xQJL54coI6kcsvtGdEcr0D
         oguMY+GSfDdmQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH RFC 0/2] Begin reorganizing the arch documentation
In-Reply-To: <87v8ir9rz6.fsf@meer.lwn.net>
References: <20230315211523.108836-1-corbet@lwn.net>
 <fe5d1e0e-0725-45eb-8b96-edcd12ae4a8b@intel.com>
 <87cz4zb8xu.fsf@meer.lwn.net>
 <498938d3-60a4-6219-a02c-a03e490103c3@intel.com>
 <87v8ir9rz6.fsf@meer.lwn.net>
Date:   Thu, 30 Mar 2023 12:52:40 -0600
Message-ID: <87a5zuf4w7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Now that I look...the only thing in linux-next currently that conflicts
> is the shadow-stack series; if that continues, it might not be necessary
> to do anything special.

There's an FPU patch now too.  Git seems to handle the conflicts *almost*
seamlessly, though.  So, FYI, I think I'll go ahead and drop this change
into docs-next, which will probably get us a cheery note from Stephen in
the near future.

(Stephen: the change is simply:

  mv Documentation/x86 Documentation/arch/x86

the only fix I had to do in my test merge was to add the new
shadow-stack document in the new directory).

Thanks,

jon
