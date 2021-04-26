Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5B36B292
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhDZLzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 07:55:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48402 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233176AbhDZLzv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 07:55:51 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4676440343;
        Mon, 26 Apr 2021 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619438107; bh=DA2ZY5lyTI/sdOtQ7fWMHCqGBMTzx3lrxBPkt1Xvcio=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Fz/EZZOtSwUPUZUtG+f9fqFhkZzZIiU1U8Zq6JKtqhMvHrRNYJYSFSykJSUmovBKN
         61ZqyeteZU9V8WPC8nWr2o7oXqQrL/XVncC8qgC5/ySbtRWLB/FhQFQIi35qbZVcAP
         L5jbJ+wp3UgTZAV1m7n0MNKvkkqBepEvmbcnpW+33DrICgLFU6GMBEUsOYIizpEpE9
         o4OvpoTyDmnkiB+3ulX12hTV1POV+AMa4++wTHEgcQyxXOPovuw3AEyg9iQat/ZBBT
         Z25UJyQbHFIm5ngpyY0I7Qs/aVFVXIVZLX3VEOw5lMnjPUIFOMMCaV+6gHae9cuyzo
         B1iSJer3oYiog==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 431B6A006A;
        Mon, 26 Apr 2021 11:55:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 31007800A8;
        Mon, 26 Apr 2021 11:55:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=isaev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="IEv4LxpX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG1KMYIGIiJVqfdc+7lRdniJ6M9I80U+KAxzKHREBqnYVAlYYaXoMPDJVyHp/jKXfR8MZel+fqRRZUh7SorMIgbfM8TE/NVF65Gkqus05pPeq8ud0Pm+ur3HvBwdace2NWlPgWHpWPhBL5ADFy3vA0rASdI1hCGlZALjWJpyCqq5YxHIrV9Zz76v3YFPXZ7A3LR0OfivVWiBPmh1FByrOolyX0h9QpbudDEPTKFfombfgcxPSw1L2aqnCixncr2/5e+sE2j1qtxcuKtfMRwbe4nl5CdOVfUVIpso8ubzlVja6XCHlQ/upBxoUQppD1orG2UTkJ7WjgubpDEG2bKpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/aExH5H//PCc7R9QgRmi0eN50zRcjNWnGbFhObQiUo=;
 b=TNvJQ7UT7r9GJfBApYwgNU+SaC9gng3ASAkMYcE74mBTa8h2/CcQc2E2sL7L8qtI4Zi46HCYiumFUQ2TAEoKopEWwlj+wfu2TTw1j7ZEPN32BroYOrMiXwHUoBHWXFU4bUVUOTlH7dE3PCnss9j4p4zihcEEbLkITRni3eoS8OSz4R/MjUSsJfmN7xzlYXqdRdRMcaPnxUmI/+y+MooYeD8DYJDtQAZ25fxEPQKK8IccRPOG4MKsPaNq+GM/8LyblGtbhMIAFkVgpsYrBLa0P4UvZzv/5RevHb2DPrKkWQbMDldOk2TQm/wrZ53+kR7OD1/zeR2ttJUfaOKSDc55XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/aExH5H//PCc7R9QgRmi0eN50zRcjNWnGbFhObQiUo=;
 b=IEv4LxpXXHxBx3awWhlz+/uuXA5MirGR8AbLvhPEXphfLjy571cNSDxpz07o0JrAAx4NxEpT2cRT9F4/GAnZWfKtk0pPW8DOveivuQJfvidTPXHNIyKMbj87zkkyrizPeeoLjC4VDXQUCR0uMdw+mvVH1bCmb2rHY48IsDp15Y0=
Received: from BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 11:55:01 +0000
Received: from BY5PR12MB4131.namprd12.prod.outlook.com
 ([fe80::3958:5a51:e148:b624]) by BY5PR12MB4131.namprd12.prod.outlook.com
 ([fe80::3958:5a51:e148:b624%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 11:55:01 +0000
X-SNPS-Relay: synopsys.com
From:   Vladimir Isaev <Vladimir.Isaev@synopsys.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Thread-Topic: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Thread-Index: AQHXOoRjvb0drZplskeVKb9Je5vvdKrGqbaAgAAGmEA=
Date:   Mon, 26 Apr 2021 11:55:00 +0000
Message-ID: <BY5PR12MB41318EB561C2E936B0371B5EDF429@BY5PR12MB4131.namprd12.prod.outlook.com>
References: <20210426101004.42695-1-isaev@synopsys.com>
 <YIakBTNpLsPJaj7i@linux.ibm.com>
In-Reply-To: <YIakBTNpLsPJaj7i@linux.ibm.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaXNhZXZcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy0zOGUwNzIwOS1hNjg2LTExZWItOTlhNS0wMGJiNjAz?=
 =?us-ascii?Q?OWQxMWNcYW1lLXRlc3RcMzhlMDcyMGItYTY4Ni0xMWViLTk5YTUtMDBiYjYw?=
 =?us-ascii?Q?MzlkMTFjYm9keS50eHQiIHN6PSI4MjkiIHQ9IjEzMjYzOTExNjk4NTA1OTM1?=
 =?us-ascii?Q?MiIgaD0ibUlrc0piWWN0V0NUWUVoeFlEUk1lNGRUV2hnPSIgaWQ9IiIgYmw9?=
 =?us-ascii?Q?IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSFlJQUFBWVNE?=
 =?us-ascii?Q?ZjdranJYQWN1ZVFmQ0Q5N1JDeTU1QjhJUDN0RUlOQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QVFBQkFBQUFrSjV0ZndBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJnQmhB?=
 =?us-ascii?Q?RzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhRQVpR?=
 =?us-ascii?Q?QnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdCd0FH?=
 =?us-ascii?Q?RUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0JsQUhJ?=
 =?us-ascii?Q?QWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhBZFFC?=
 =?us-ascii?Q?dUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QnRBR2tB?=
 =?us-ascii?Q?WXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUhRQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFIUUFjd0J0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZFFCdEFH?=
 =?us-ascii?Q?TUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR2NBZEFCekFGOEFjQUJ5QUc4QVpB?=
 =?us-ascii?Q?QjFBR01BZEFCZkFIUUFjZ0JoQUdrQWJnQnBBRzRBWndBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWN3QmhBR3dBWlFCekFGOEFZUUJqQUdNQWJ3QjFBRzRBZEFC?=
 =?us-ascii?Q?ZkFIQUFiQUJoQUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUdF?=
 =?us-ascii?Q?QWJBQmxBSE1BWHdCeEFIVUFid0IwQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFiZ0J3QUhNQVh3QnNBR2tB?=
 =?us-ascii?Q?WXdCbEFHNEFjd0JsQUY4QWRBQmxBSElBYlFCZkFERUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFHVUFY?=
 =?us-ascii?Q?d0IwQUdVQWNnQnRBRjhBY3dCMEFIVUFaQUJsQUc0QWRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQjJB?=
 =?us-ascii?Q?R2NBWHdCckFHVUFlUUIzQUc4QWNnQmtBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [178.71.48.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f89ae65-3a3c-43ba-713f-08d908aa1f36
x-ms-traffictypediagnostic: BY5PR12MB4292:
x-microsoft-antispam-prvs: <BY5PR12MB42925D6FBC2410897ABD4FB1DF429@BY5PR12MB4292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BjAgH7WVcxKJhJCmY7cDlLbS3/mr/unFj6skxn258mlgBXxZWa1fMf2hU3vC/mTNlSUqNkE8Eh5Efw76RntBk34fyeoE3H0CCxtOJuo9UdCL25amY4WBP6mR8B2rVckKibYxib/jQ5MUffYhoZzE+3NLShan0bZF15wh5hqU0UApVzCBu0dG/PFdNS+GPt3FR6GTYsbs1SScZUwdY/Wi39itloz9w5NIuPTam3CflvGr5pWX3X2l9P84yI1o9Vch/HFBQFxmzPDoNHJyJVKEKIe5Asf+EPvKpFDyEoVspWinJslWAXWFnoIpjxggDdkkqF9hG1YOOYXdgfyPkofHZ+4+Qkv/XIP/jcW6hAcTn8lU1bHJN4yeKir3kPn6pLIXpf7pCEqNL40Ujegjh1R+/knPssvXZoPplqmHmaCR71M5BgMmE11LxRWp8p+VVxnLx8dXcKQNtgtjy//OXUgEWNzKnICZ4XGf+ekZgm7kj2cGwAHxFDkD6HE32m7jCkTfm/jl46RFolI4lr6m089v9b//Z9t0LKiQX7ltfAjOboQI99VQ24LLDx4cc1iq8pyRQ/OvOf+OoJezydpg324kGCGIiSxKK2u+uVHufVjsmjk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(71200400001)(186003)(26005)(9686003)(4326008)(38100700002)(55016002)(122000001)(33656002)(6916009)(6506007)(316002)(76116006)(4744005)(66556008)(66476007)(8676002)(8936002)(64756008)(66946007)(66446008)(478600001)(5660300002)(7696005)(86362001)(2906002)(54906003)(53546011)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/WXJ+VoFMxFB82PhNX1UZVTGurKVMceILhfukQ0biNBnLB37nOrgcLvOLcq4?=
 =?us-ascii?Q?ANgiVPYBtb+ZlRsLaob23+LMWc3OTCpvTor0d+pWfj7pj32U8WJ3e2S1AuGU?=
 =?us-ascii?Q?+0kC8GlEosHnioB7GqgrZ0BFYXsFn8r/vELhmuj+8cF+csAU6zaJ4SPdcWvp?=
 =?us-ascii?Q?aMNXI0YkaDZjVeJuw3pMQnbImTR7uxSR61THE5LCIrJf/qTmpKv3ZdHaskxF?=
 =?us-ascii?Q?7h69tAxj255Uiglji6wuXvFhUwvso67J9WHVR6yNBlMtKVyPnVeAbm7Mgbsp?=
 =?us-ascii?Q?9P9aQl4UI72YErCkG1IUQfRPukv9ohMPt7KgRSzfP/ia29bcorTBBc03uN0R?=
 =?us-ascii?Q?io2d3I62kAKSncJO1D6PegOZUG+ijoU+u2hVq5l0Z9mYrqF0CmrzkpnfSPGA?=
 =?us-ascii?Q?24n+kZ2Llclejsl73CoTu4ICRY16fsNefqvupZNYcnxsOC7E2wNZ/GAXd6LC?=
 =?us-ascii?Q?9Pt7HbiKQcNgArjwe1aFQZelsoP0fa5dAlA8ZDl9JkRCwHBFBfZIRtz0Hyd/?=
 =?us-ascii?Q?A4yU3kjToiQDZ51T6wpUJ6NXFMWFWLdbig5sTtkUKhozhTz2+vxqiDlhIXhj?=
 =?us-ascii?Q?ZqjCxzWmBsA2jR3E0QAIvyx/lZt4bIbPqbbwaooHr3rgGW1XXGauNRLl+gmM?=
 =?us-ascii?Q?OwYWOFlwP8314MZBmxE+m85AEXdDT8eZldj7R9QdXy1TbZMDK9UxIlq2pMlj?=
 =?us-ascii?Q?9zvzBG3WcVUzs6nmu8BwQ5GaWHYrDqtt3sRAjQc62Zy/1f4+ZXmtIGTNF0gw?=
 =?us-ascii?Q?UqUa6s3W1RvtF2lDnk+tUuaGn0HaGxaV6Fn91mbfnWZzAPUkNx1JygncPmWU?=
 =?us-ascii?Q?5aRNThaMFflpc+1A3SArnuuMA/UgPtCThcSTM0b+5voEv1tsb1nkdB3YO214?=
 =?us-ascii?Q?Dl9BkB+YIVG1dvwJcN8n4HDF+8LqH2qIorpaFCXT4Z1k2olfMyQaG0E2ap8E?=
 =?us-ascii?Q?lbmSQvxtJGnm9+tQx3y+xazmZUoeXwMSnWHywPqWl7djZc+HEuboe9xBwRmY?=
 =?us-ascii?Q?O2W3cNq2jAFaJc2l+ExpuUjVJvXiXFTUViCX/w4kWqAFXgEFZmt4nZE14S2c?=
 =?us-ascii?Q?8SDSlP77i19WdCDb0/fw0GO7eGmmhMpfcBDqCfwZ+cmObCZuYGi4yRkz9dlg?=
 =?us-ascii?Q?/VGVR8Fi9d8ilSt3+NRDMvZPb+/Q80Sba0/2yltN+CyGuRuFrLXgorUeylL5?=
 =?us-ascii?Q?inp4SpzareL0yWAXk8+cJmQl3+mlmdwonvIrdjvwETA8g03STu56HYi8evIl?=
 =?us-ascii?Q?bIeJxIFZHgK2mhB0s9ODjjXjRL16xkVEIwLYyNl3Wp3+8Bwq04zv268s/bh8?=
 =?us-ascii?Q?bXK4WDR7N9kheCSJ4W/KZlx4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89ae65-3a3c-43ba-713f-08d908aa1f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 11:55:00.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLLTFj380K+O8mIwkbEn0XIEhAoGWwCk7n2D6LQyjIiuUkJHc+t+lwDQMx74T5Ot5jQeF3IPmsHsG/yDR2M39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On Mon, April 26, 2021 2:29 PM, Mike Rapoport wrote:
> On Mon, Apr 26, 2021 at 01:10:04PM +0300, Vladimir Isaev wrote:
> > -	max_zone_pfn[ZONE_HIGHMEM] =3D min_low_pfn;
> > +	max_zone_pfn[ZONE_HIGHMEM] =3D max_high_pfn;
>=20
> This is correct with PAE40, but it will break !PAE40 when "highmem" has l=
ower
> addresses than lowmem.
>=20
> It rather should be something like:
>=20
>         if (IS_ENABLED(CONFIG_ARC_HAS_PAE40))
>                 max_zone_pfn[ZONE_HIGHMEM] =3D max_high_pfn;
>         else
>             	max_zone_pfn[ZONE_HIGHMEM] =3D min_low_pfn;
>=20

Not sure if I understand why we should have min_low_pfn here. In !PAE40 cas=
e max_high_pfn just will be smaller than min_low_pfn.

Thank you,
Vladimir Isaev
