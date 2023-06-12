Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD272C485
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjFLMje (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 08:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjFLMjd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 08:39:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD26170C;
        Mon, 12 Jun 2023 05:39:03 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8CB3F365;
        Mon, 12 Jun 2023 12:38:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8CB3F365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686573537; bh=dey+JGeWTZPWtZTeJQcExJFyDRQuARe06SW4DQOIbgo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Cc7yUuvQmubIRCx0cphbyzLTHq0GVKDIsBwvZtgIZgUf8kphAHzD9nipL18iloh1z
         mIh459BF3S3pz/D4bBhdZ6VZdKsilj53RT7qn+YDSEnW5LM/MgFCbTPal7Lp/rhRtd
         va6oes6kwa5zhs8v7Ny0Ea/PLF1wzBzO44ak6rYcjFYeXCBh4tZ+6850b+4UGxGTXT
         u8nBrI0Q8YOGY7tGkz9C5cR1d1CIakEBkpSyJS85q3AXotq4a38i4B7PxQgkmRwjB6
         dSL1cnimtCJLXfmYZMHAFjLaWNc73+NwnLMZYY6FcvK6P9vmUT0iXrlbNTy9twePYr
         dKzl2eUvoLHfQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] docs: Move Documentation/arm under
 Documentation/arch
In-Reply-To: <20230529144856.102755-1-corbet@lwn.net>
References: <20230529144856.102755-1-corbet@lwn.net>
Date:   Mon, 12 Jun 2023 06:38:53 -0600
Message-ID: <87h6rcn9cy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/arm into arch/ and fix all in-tree references.
>
> This is one of the more intrusive moves (if not *the* most intrusive), but
> the changes are all straighforward.
>
> I'm happy to take these through the docs tree, but the potential for
> conflicts might be less if they go through an Arm tree instead.
>
> v2 changes:
>  - add tags
>  - remove ahead-of-its-time MAINTAINERS change
>  - proper changelog for patch #7
>  - IOW: nothing all that substantial.

So nobody is clamoring to pick these up, which is fine...  unless I hear
screaming, my plan is to drop these into linux-next shortly (no
conflicts at the moment) and send them linusward in a separate pull
request during the merge window.

Thanks,

jon
