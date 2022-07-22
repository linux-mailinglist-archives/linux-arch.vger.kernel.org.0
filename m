Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512FD57EA16
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jul 2022 00:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiGVW4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 18:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiGVW4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 18:56:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBC37F96;
        Fri, 22 Jul 2022 15:56:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so5488797pgb.13;
        Fri, 22 Jul 2022 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QHz11oQeWHexBI56qDzwQXLxjXmaVbVkx6Bas8PmE/k=;
        b=Ka+ldo0XLtywqq9IwQWZHdMH1dcCO2laspYwU+Op0InQlgp+ogZlovkLGm0DFFuQ/k
         fiHpzEjPIHaMSVKJWqqKAWeBY6r3qcMyNITEJD7s8SEqjAuCuzbd94YZN5lT4XOSECli
         /bnx4vnZI1HO7VFrHsUaEhWya7uD7oaNlBq2TrBrzNACWfrkUPkrdRt7FJlNJ/ntBgKz
         fkwj4EN9wJVaSiexE7LNp+EqHEhjbJ+Q+OT73Dc9gq7EJqakTbEM50Ci0Dr49BBWyxZ8
         287X03pnCwfiKX+9xZ0AUU2My1OT8Jhrr7lx37rBQcjMowlf6q37R8vhEIx7paGvCuaE
         0nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QHz11oQeWHexBI56qDzwQXLxjXmaVbVkx6Bas8PmE/k=;
        b=T+2SU4YWBdHLfAAOumYvGLMmW1XXcQ04UauV09cDTEqfoMptZvTO1Q283xrffL5qaE
         XFBHFdHl5tB0FGjwVAXbAnPEJ4Es6eMejmLg2ix/XH0RMX/USWHHGQPKRYi3v7OBnJRK
         YqRSs7KcXuZckEcZfrqjpSvqeMPf5Q3XjBF1bB07mTh/SkG9sLaM9V2evy7gpaAD7ruH
         KsqyPSAvxwXeMzbYgyUJkoNsBf7mucEziqQ6WE8IKYXuIL1barZD+WUK0Tw8Nr99p7EB
         3JPfUF3SEzmi/dDyidoII4AkcMddsZiZpooEkoxvYvONGMmLTJ/Q0KSq3M+dpi1wSgcQ
         QvKw==
X-Gm-Message-State: AJIora8f43e8xJ5fm1nfblWx2aXmyTmblxj0r/tFZ9rBIl6C3mF8zIjT
        CAWkz6/+aFUN+2rqKDtv+tE=
X-Google-Smtp-Source: AGRyM1ssgspuNhoA5Gk+4Uhjl6x5FR+5SagZFy8Le8E2u02NnQwVlEOFcwcDrNPisPsRABzcoxkccw==
X-Received: by 2002:a05:6a00:855:b0:52b:213d:fc03 with SMTP id q21-20020a056a00085500b0052b213dfc03mr2139243pfk.31.1658530601024;
        Fri, 22 Jul 2022 15:56:41 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a6b0c00b001f229f07b27sm4007457pjj.12.2022.07.22.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 15:56:40 -0700 (PDT)
Date:   Sat, 23 Jul 2022 07:56:38 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Message-ID: <YtsrJghwLPf3uj4W@antec>
References: <YtsaA2Zjqa/XZZou@antec>
 <20220722223146.GA1947394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722223146.GA1947394@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 05:31:46PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 23, 2022 at 06:43:31AM +0900, Stafford Horne wrote:
> 
> > I will respin a v6 as we didn't get a reply on this.  Bjorn are you
> > planning to apply the series before the upcoming merge window?
> 
> I see your v6, and I can apply it.  I only got patches 1, 2, 4
> (without the csky patch).  Do you want that to go a separate route?  I
> don't care either way, but not sure it improves things to split it
> across trees.

I sent 3/4 directly to you now.  Hopefully you see it.

Patch 4/4 depends on it in a sense so its best to keep 3/4 together.

-Stafford
