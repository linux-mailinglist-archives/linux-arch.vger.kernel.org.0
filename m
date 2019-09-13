Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CCCB2531
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfIMS13 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 14:27:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38554 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfIMS13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Sep 2019 14:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rUHXVclZXHF+9qsNmXDNmKFf2GeFqSzWSuwkR1JCZ7I=; b=0S6NAFBooMrp44Rx9duwP6fvW
        ILLr/ywXbzUq3/H0KKZY+AqA4DUuQJVWiCgncsKYkGZgmaKmhl3hAje8C0yv692H5cWHsaRPU//Xe
        8ZF8H40qaY0yT3zp728l67JIs57A3yiPMqE39lGW7BL2dJbxW80slK+E4wJ97WAv4dSaB4colLC7d
        h1EeWjD4ELQhsppY//bfGtxRj8y3zTeDtNlfXwk3NenC56szHq4IuYr3ioB96km+6Ygsmi3Avx18T
        4/Vwg+nNM/lILz0tmPnzrP+JCUFABB/id+2OJv4D8DoOSFrv0AhgHtkuxKHbjwyhVjG0o7fAfKhaf
        G6YGHr6jg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:39110)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i8qHu-0004DJ-Po; Fri, 13 Sep 2019 19:27:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i8qHp-00064I-Jr; Fri, 13 Sep 2019 19:27:13 +0100
Date:   Fri, 13 Sep 2019 19:27:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        tglx@linutronix.de, will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com,
        davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC PATCH v2 00/12] Unify SMP stop generic logic to common code
Message-ID: <20190913182713.GB13294@shell.armlinux.org.uk>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 13, 2019 at 07:19:41PM +0100, Cristian Marussi wrote:
> Tested as follows:
> 
> - arm:
> 1. boot

So this basically means the code paths you're touching are untested on
ARM... given that, and the variety of systems we have out there, why
should the patches touching ARM be taken?

Given that you're an ARM Ltd employee, I'm sure you can find 32-bit
systems to test - or have ARM Ltd got rid of everything that isn't
64-bit? ;)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
