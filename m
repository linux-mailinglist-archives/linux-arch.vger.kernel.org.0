Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD75103A3
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353032AbiDZQkO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353028AbiDZQkM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:40:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0687DEA1;
        Tue, 26 Apr 2022 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650991024; x=1682527024;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YkchwpoFBWYE6wjpBeZGz+2BPwCBUpcUNyTQQIFBqC8=;
  b=fLbV+umM1okXVQ+opaeKUa4wNxnCdAzm4VnPEF/Hs9JbF7BotaUAB3lF
   +8/U7u3Q0z9WIhRb4GSFMsLJ4/V1+i8kJ/QFzbju8etjyTdBQgzzCEg+M
   7fWePO0cEhsoNrbvSI9kO9ya5OtaK5FqwGgSJfNizUGe9P02X6uPCDMUa
   133RzbODLblYJbbu6rmBDBLeZc7moxEYOB6eaAoFFtFKnNyYUw5uQyWsM
   6Gt7zJ5+Fmll5TXWf9FkU0QzYKrCfj9UxWoEpprDy6gIKahKLqoSTHBfu
   KE7QWlVl8q1PdUqJXKm+WtUxY+nBv1lX9BsdJOHLBPRfY69g6ARz9eS2H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290789633"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="290789633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:29:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="580016188"
Received: from mmilkovx-mobl.amr.corp.intel.com ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:29:11 -0700
Date:   Tue, 26 Apr 2022 19:29:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-api@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 05/10] serial: termbits: ADDRB to indicate 9th bit
 addressing mode
In-Reply-To: <Ymf9UhyXj7o8cNhq@kroah.com>
Message-ID: <9a9dda88-b239-9c63-82d-2f7678fdbf9@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com> <20220426122448.38997-6-ilpo.jarvinen@linux.intel.com> <Ymfq+jUXfZcNM/P/@kroah.com> <b667479-fb27-8712-cec8-938eed179240@linux.intel.com> <17547658-4737-7ec1-9ef9-c61c6287b8b@linux.intel.com>
 <Ymf9UhyXj7o8cNhq@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1964830911-1650990558=:1644"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1964830911-1650990558=:1644
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 26 Apr 2022, Greg KH wrote:

> On Tue, Apr 26, 2022 at 05:01:31PM +0300, Ilpo Järvinen wrote:
> > 
> > ADDRB value is the same for all archs (it's just this octal vs hex 
> > notation I've followed as per the nearby defines within the same file
> > which makes them look different).
> > 
> > Should I perhaps add to my cleanup list conversion of all those octal ones 
> > to hex?
> 
> Argh, yes, please, let's do that now, I totally missed that.  Will let
> us see how to unify them as well.

Unifying them might turn out impractical, here's a rough idea now many
copies ... | uniq -c finds for the defines (based on more aggressively 
cleaned up lines than the patch will have):
     89 1
     74 2
     14 3
     58 4
     11 5
     54 6
There just tends to be 1 or 2 archs which are different from the others.

...I'll send the actual octal-to-hex patch once the arch builds complete.

-- 
 i.

--8323329-1964830911-1650990558=:1644--
