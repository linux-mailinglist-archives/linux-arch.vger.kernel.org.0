Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23B7B0A94
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2019 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfILIru (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Sep 2019 04:47:50 -0400
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:46879 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:47:50 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 04:47:50 EDT
Received: from localhost.localdomain ([93.146.66.165])
        by smtpcmd08.ad.aruba.it with bizsmtp
        id 0Ygg210103Zw7e501YghBC; Thu, 12 Sep 2019 10:40:42 +0200
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     linux-arch@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: Multidrop support
Date:   Thu, 12 Sep 2019 10:40:30 +0200
Message-Id: <20190912084032.16927-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.17.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1568277642; bh=WKQgoo/OQnSOPed3t7cxpZYmsATL5nd373EdG9nnhYQ=;
        h=From:To:Subject:Date;
        b=QEqIGi0RqVElHMvyluMiVzEA3qJ9z22X1MyVdvXg3UTIUD0lcT1wfjVAqw38HrE4Y
         SwqIeSgVBqeMbQf0D2DV5BRlZZeZCDLA45gCTsXSGVDeb3uLMQK+1IeCFw0wSrVe/n
         qrcrUt59vnfAkPtj03dsUZph7Qe2RBYkL72bOXcoyGyXtaUl5VLqyZ3e3Ad51UiGk4
         kEZ5LdpBdzG5fKAw1Fa1zpUw5UA276WPpSnNXrqNVr8Ikv239A/eP5lJMKD2BV2+tk
         NdwsrvtCpggZLfQ5/idRsurETfmWh5x67F9816hgiHNygG2JGxnk+V3WawLvVVh1s7
         VFdXH6wGImutw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Here are two patches to introduce multidrop support.

First one defines new termios bits useful to enable multidrop support,
while the second one effectively implements multidrop for the
Atmel/Microchip serial controllers.

Of course other serial drivers can do similar steps if the hardware
they control can do similar operations.

Rodolfo

