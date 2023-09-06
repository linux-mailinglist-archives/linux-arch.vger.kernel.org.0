Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2958079442D
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 22:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbjIFUB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbjIFUA7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 16:00:59 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 13:00:53 PDT
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A719A2;
        Wed,  6 Sep 2023 13:00:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id A7AB858128A;
        Wed,  6 Sep 2023 15:53:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 06 Sep 2023 15:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694030003; x=1694037203; bh=VH
        oiOAVzKFrc1qoVv7v9Mr1BrXqTyFKUxLZW2/6sh7A=; b=B9YGq+m+TaGkZYwKEv
        mwtpybd3N+c0fMrFAnCMSThlV38UxHGUZar4YL61wnZ8hebh7VNwhdEot1JcM314
        t90DsstQsCqV320qKAeQxaOy7tIjIN6MM/i7+eNgzBWjvsQZqPhhSdxBflKsD8i4
        ZRmBezwM15eJWbtMRS/w4aPfiuZYSuhzLqNmuw0oqg7NEL0rlnGLcZEyGKEzrxEN
        G08pXwkhHEmxCZCmVwpMqwrwJ4jOuXUkafTKfsioh4wptnHthM/+o0QpCzaVlAt5
        p2HsVsrVY9rdSP1XPW2+akPPpXdZ+NhnO5DN6OVHV68jOgT0d4LVctgdofyw14lg
        P1wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694030003; x=1694037203; bh=VHoiOAVzKFrc1
        qoVv7v9Mr1BrXqTyFKUxLZW2/6sh7A=; b=0eyhXlcs6SwaXsTsohvaVHSDkEW5t
        pf9IsSwsFxNCmJrnjsC1r2Ar4uKNxAccIwEZcHP0Glfwt7Pk+h/JnKu5+mRrT8Kq
        IhOhf9SukEJcq9eb/lSO1m3E0oyB542WZP6lVYMF9zXLOsG7pFDQA7FcQlbIGsWO
        v/7uE15f2PEQTL46VW9VAMeDZf2i5MRnBuAxMk289lztpWbEepsINFs8crl/i4pi
        cZ6D7fyA0rWRODs/fQ5p4A4vUmfV2n21gu6zI9vyGqm0BY+5Rsgd482HgncvaExW
        Sz8l5d7mijRz1HFOBAzL8e10OB5UlqpB6CLhAj7KXk+bFmgGbRpuCuFfg==
X-ME-Sender: <xms:stj4ZMFT5bUXIujyx8rG3XMkkz8xGkw5hclkerDPojseR-OAKoh2EQ>
    <xme:stj4ZFUrxldM_py_4Cti_MuQgJweGk5z0Yka0QIrf8JQxP8NlU6tdbgihMPfx7dbz
    agIOq8G_U8LGbygxoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:stj4ZGIpCwrWbQMuQnRKui1vq0jlD_Hw-xaxveFWC1c7nV6BvZOFpg>
    <xmx:stj4ZOEWKrXyPg7eu5ukVGzSe0cetY7fwF7mwZBQdjSY6eR8XT8jvQ>
    <xmx:stj4ZCWoKWWomrXTKgZTmEmwM7RaOCq6OifEZR2NKWwutIUZbzo0SQ>
    <xmx:s9j4ZLONDqSf7o5Z4aSE1onERACQAtFksbMuJmduHrqscQGtXIS0jA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE25DB60089; Wed,  6 Sep 2023 15:53:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <8865aa0a-ec40-41ca-a77e-9172cec49f07@app.fastmail.com>
In-Reply-To: <20230906144801.25297-3-tzimmermann@suse.de>
References: <20230906144801.25297-1-tzimmermann@suse.de>
 <20230906144801.25297-3-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 15:53:02 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Helge Deller" <deller@gmx.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] fbdev: Replace fb_pgprotect() with fb_pgprot_device()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 6, 2023, at 10:35, Thomas Zimmermann wrote:
> Rename the fbdev mmap helper fb_pgprotect() to fb_pgprot_device().
> The helper sets VMA page-access flags for framebuffers in device I/O
> memory. The new name follows pgprot_device(), which does the same for
> arbitrary devices.
>
> Also clean up the helper's parameters and return value. Instead of
> the VMA instance, pass the individial parameters separately: existing
> page-access flags, the VMAs start and end addresses and the offset
> in the underlying device memory rsp file. Return the new page-access
> flags. These changes align fb_pgprot_device() closer with pgprot_device.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

This makes sense as a cleanup, but I'm not sure the new naming is helpful.

The 'pgprot_device' permissions are based on Arm's memory attributes,
which have slightly different behavior for "device", "uncached" and
"writecombine" mappings. I think simply calling this one pgprot_fb()
or fb_pgprot() would be less confusing, since depending on the architecture
it appears to give either uncached or writecombine mappings but not
"device" on the architectures where this is different.

      Arnd
