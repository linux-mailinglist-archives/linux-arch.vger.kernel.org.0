Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18C520B4D
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiEJChe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 22:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiEJChc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 22:37:32 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 19:33:35 PDT
Received: from server.jpvtrading.co.uk (server.jpvtrading.co.uk [77.68.83.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643822D619
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 19:33:35 -0700 (PDT)
Received: from server.jpvtrading.co.uk (localhost.localdomain [127.0.0.1])
        by server.jpvtrading.co.uk (Postfix) with ESMTP id DBB3310627C4
        for <linux-arch@vger.kernel.org>; Tue, 10 May 2022 02:27:36 +0000 (UTC)
Authentication-Results: server.jpvtrading.co.uk;
        spf=pass (sender IP is 127.0.0.1) smtp.mailfrom= smtp.helo=server.jpvtrading.co.uk
Received-SPF: pass (server.jpvtrading.co.uk: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=postmaster@server.jpvtrading.co.uk; helo=server.jpvtrading.co.uk;
Content-Type: multipart/report; report-type=delivery-status;
 boundary="----------=_1652149656-31536-2"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: BANNED contents from you (.exe,.exe-ms,pmlyg.bat)
Message-ID: <VSZ9FY344gbQdH@server.jpvtrading.co.uk>
From:   "Content-filter at server.jpvtrading.co.uk" 
        <postmaster@server.jpvtrading.co.uk>
To:     <linux-arch@vger.kernel.org>
Date:   Tue, 10 May 2022 02:27:36 +0000 (UTC)
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1652149656-31536-2
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

BANNED CONTENTS ALERT

Our content checker found
    banned name: .exe,.exe-ms,pmlyg.bat

in email presumably from you <linux-arch@vger.kernel.org>
to the following recipient:
-> customs@cms-logistics.co.uk

Our internal reference code for your message is 31536-15/Z9FY344gbQdH

First upstream SMTP client IP address: [121.34.33.227]:14221 

Received trace: ESMTP://[121.34.33.227]:14221

Return-Path: <linux-arch@vger.kernel.org>
From: linux-arch@vger.kernel.org
Subject: Delivery reports about your e-mail

Delivery of the email was stopped!

The message has been blocked because it contains a component
(as a MIME part or nested within) with declared name
or MIME type or contents type violating our access policy.

To transfer contents that may be considered risky or unwanted
by site policies, or simply too large for mailing, please consider
publishing your content on the web, and only sending a URL of the
document to the recipient.

Depending on the recipient and sender site policies, with a little
effort it might still be possible to send any contents (including
viruses) using one of the following methods:

- encrypted using pgp, gpg or other encryption methods;

- wrapped in a password-protected or scrambled container or archive
  (e.g.: zip -e, arj -g, arc g, rar -p, or other methods)

Note that if the contents is not intended to be secret, the
encryption key or password may be included in the same message
for recipient's convenience.

We are sorry for inconvenience if the contents was not malicious.

The purpose of these restrictions is to avoid the most common
propagation methods used by viruses and other malware. These often
exploit automatic mechanisms and security holes in more popular
mail readers. By requiring an explicit and decisive action from a
recipient to decode mail, a danger of automatic malware propagation
is largely reduced.


------------=_1652149656-31536-2
Content-Type: message/delivery-status; name="dsn_status.dsn"
Content-Disposition: inline; filename="dsn_status.dsn"
Content-Transfer-Encoding: 7bit
Content-Description: Delivery error report

Reporting-MTA: dns; server.jpvtrading.co.uk
Received-From-MTA: dns; server.jpvtrading.co.uk ([127.0.0.1])
Arrival-Date: Tue, 10 May 2022 02:27:36 +0000 (UTC)

Original-Recipient: rfc822;customs@cms-logistics.co.uk
Final-Recipient: rfc822;customs@cms-logistics.co.uk
Action: failed
Status: 5.7.0
Diagnostic-Code: smtp; 554-5.7.0 Bounce, id=31536-15 - BANNED:
 554 5.7.0 .exe,.exe-ms,pmlyg.bat
Last-Attempt-Date: Tue, 10 May 2022 02:27:36 +0000 (UTC)
Final-Log-ID: 31536-15/Z9FY344gbQdH

------------=_1652149656-31536-2
Content-Type: text/rfc822-headers; name="header.hdr"
Content-Disposition: inline; filename="header.hdr"
Content-Transfer-Encoding: 7bit
Content-Description: Message header section

Return-Path: <linux-arch@vger.kernel.org>
Received: from vger.kernel.org (unknown [121.34.33.227])
	by server.jpvtrading.co.uk (Postfix) with ESMTP id 137DC10EB129
	for <customs@cms-logistics.co.uk>; Tue, 10 May 2022 02:27:08 +0000 (UTC)
Authentication-Results: server.jpvtrading.co.uk;
	spf=temperror (sender IP is 121.34.33.227) smtp.mailfrom=linux-arch@vger.kernel.org smtp.helo=vger.kernel.org
Received-SPF: none (server.jpvtrading.co.uk: no valid SPF record)
From: linux-arch@vger.kernel.org
To: customs@cms-logistics.co.uk
Subject: Delivery reports about your e-mail
Date: Tue, 10 May 2022 10:27:03 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_FD47E436.8E205FE6"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000

------------=_1652149656-31536-2--
