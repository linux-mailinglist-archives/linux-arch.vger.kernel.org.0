Return-Path: <linux-arch+bounces-7356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013697C880
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2024 13:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1971287D9D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67219CD16;
	Thu, 19 Sep 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="flWnnd5C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bwlUP1pZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4A19B3CB;
	Thu, 19 Sep 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744857; cv=fail; b=Hdceu8u5QLm+oN2G3Z+LU5bvvKbvrOK6YdLxsDMWEpq8uCKJZd2Sq9XOQBZpyYbRyyi2SIliiH7IEZMDuyC31wIGCj6v8j0CfwOiz3AQJOOsXt8tXwt1KBebQchRgglZ/zQzDJ7N+JO3gUH9QQKPumjKFyPuvSSwit84kazRrKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744857; c=relaxed/simple;
	bh=h35Z7jFPMdDBGW4sdp8EPAEq5lDsn/fpEzB72ONnr7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ITjQOtzff7c52Oso4z7tVcJ6OF5JkECmRfFR8Qm3qHh5zYa9jKTwF1G0PgBxUtmP1jtjJzYRnODrGR5ALwESjSJ6O5ADa0q2KEbH15niVv3nQaO0xN/uV7SvpK9ZJ09HpBuZ8V++6OWI92ZA+T5KMIvlW3lpgEZXZz3BiqOqbmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=flWnnd5C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bwlUP1pZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J9P8Nd015124;
	Thu, 19 Sep 2024 11:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=LKW+WYsbqt0I4Vl
	IrZ/Rmvop8f6rSxsgpaANlbO4Bzw=; b=flWnnd5C0I7TKHqz8FD17WK1B+q1T4G
	W6Sp1pWveHhYGhsBWfTXkbzCxJQLx3X5B9CdO5jW86JRZ8FNhGrVGXG7rklxYvJP
	ZCFCTe6RBsc8qtDUVoYf0inO3jCUtSbI4V01QeLYWfa04OQzGhz0rsvKknJB+W0O
	WA+HQPHxit2XVCuCFZquC2erfm0qbhdEH2LBALdzZ6dhPE7QAtmDVhezkbxM3dth
	2QRI1cXFabjBXkYYvCkK/+AxjuCerEC/UzDc7Ene+sMPaaYx8XrK6iFVmwTId0XI
	FNGoJoWfG1CU++oMuEFlObCH9LcjaMHNsGb2cr9rsXFMxMyMc9nyzlQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfush1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 11:18:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JBHakb015810;
	Thu, 19 Sep 2024 11:18:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg5wwr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 11:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXQq9DSGmITPmehAW1gfmmOSz5QQoFmyTMEBcEYajkIdrSCPQZuiz+BLpdVrNZHoWYX7/4JJ9lPUhi6t65Auv/z0ripaYCRrl+XScAWUtS6CaPIPaaJ2/72f0Rn1Zl6eIR4DExzvwAEg6Kuudem3kO/ojkwDH19QuP/Ik1N/tFDVmTn6hVNaZoHXsXXMXW2O014yPSABZcyCD6RqHeDKRG6Dzf1mq57qGwpqcH+Hf/QdfOrnAWDAN8d5sGkfuW8HY1QwraOZs4H9RTXd7zSEdxcrqYzrEqqVNqxcRRFVaoZiYptan92mgqD2OWo5KNQxYLeFDKgO0+BWwPTwC42heA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKW+WYsbqt0I4VlIrZ/Rmvop8f6rSxsgpaANlbO4Bzw=;
 b=pxOS+wbMppX9NftzhhukasE1L/TcV9oVLpLNVb53P8erVkrfEGg69hku5zdx8rbsdLcaqyg4cEJc3BXUM/9PIj+Gw2WHTVZvh8zpKOInu9RXqIZc3UGHKpIT9XH/cLIB4vtFygt9IKOeuwnTzlDC3D+fN9C7Kq4y5O3n9hbJaxlTFHKsAhZReaAvUWZaBNblRd2ju7eJYQLtMQWeX28HQ44hQj8SKwXlHPSbQD9PyoV41Ur9CEBDLz1r34c+eWDB264EZivYIGS3OXpQ9MeOXNoaWz5jOAJNZfvFJKEs5kZjxHxIjL+7qYbo6Qw3qTqIZpMGFSsb9IuT+l7zoIxWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKW+WYsbqt0I4VlIrZ/Rmvop8f6rSxsgpaANlbO4Bzw=;
 b=bwlUP1pZ9Avi/mF5VKWiLoYUkI5V6zdMKtz6y7zYelAYbKc+50zCwbqbNK3rgwe7chuDPlE2SuIzGoLsRYHhD3+NHiug5/57q2WiPhaiXDyTe0UaMcuR5Xskf8G+Q4zTAFvfHORssa92+EYuvlXiPicVjheqepRuWQyqGMnGWbw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Thu, 19 Sep
 2024 11:18:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 11:18:29 +0000
Date: Thu, 19 Sep 2024 07:18:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
        Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 7/8] execmem: add support for cache of large ROX pages
Message-ID: <kqxjtkyscnl2qolo4wumvmrwwkljmp2nap2ylcktr7h3aozm22@afq3rvjjsqes>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, sparclinux@vger.kernel.org, 
	x86@kernel.org
References: <20240909064730.3290724-1-rppt@kernel.org>
 <20240909064730.3290724-8-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909064730.3290724-8-rppt@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: VI1PR09CA0163.eurprd09.prod.outlook.com
 (2603:10a6:800:120::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cf09d5-08da-41d9-bf62-08dcd89cc989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/c3bPSvRNkM1zB0JPTJKWhlbvEUQjtct70RaCHIYLowdqMHeRlbkYgtxWeG?=
 =?us-ascii?Q?o4gSE2wpskSUq1smL33Q4XzYVJ8UgGU5rd++ab/25ZdlEP27Z5kKpMvDdoXX?=
 =?us-ascii?Q?Dnq1kQZIZLrbWq4d5vr8zSkA4oplzpAoBw3yh9v0DRCtYOPXRV7mIP+sHpav?=
 =?us-ascii?Q?PAxZ4L+uh6nTd3zBPmEl5E/SHUHLhtAl4nAhYICe3PwsMhS5meTYHSenCv/v?=
 =?us-ascii?Q?MSNZQhn7UlZc9CCa+pzkdX1SJfQEFs6mYZd+/uRO8pX8N6JnbefJmTgWi2Pl?=
 =?us-ascii?Q?ZDxc5QVrkl7VIr1bZWGc6Zze/QrAgGmqIbU5lpvLYFnDbsxNFHTb5FnK9LL/?=
 =?us-ascii?Q?YkxhMVwxahqpcA9Itv+LIDb/Jqy+WgT0cLzPBTQdBT/4+XpUfXait+ZGpO3c?=
 =?us-ascii?Q?6L7vD2mY6oapsYdXY3sWIavb2iuZqn+YAHFfFH8pK3a1ijDt+79YtluYVQaP?=
 =?us-ascii?Q?6ZSR8gojr2ZOCsyXu1t1SiS2EyZ0bVDQ/14+rfkASz93a69X+b2QEStKlSg1?=
 =?us-ascii?Q?S3zumi1n+oVuG4S/iVYpUTct8+LMMmb3I2xcfkIPICmgBhIPjRP2ZYq3of0S?=
 =?us-ascii?Q?UksVNkME67D4JVPpo+4sV1NKfB8efQLai/Apl+yjR5bgzK0ULHfwtQmE3ZV/?=
 =?us-ascii?Q?3M7NjMa9Fr+xQch1xj7rtFRK+Zfv4ldKcOTIRDry+86Wx/8p8UtmH/N+FCLw?=
 =?us-ascii?Q?9Hb03uwopKRrJlTUi68L0iBXjObS+ejplHI/ocpu29KsBeTYWHEr0ZgateyE?=
 =?us-ascii?Q?KKrl7dCBb2fjgcq+WJGn2zqzLLKOOretQpzZrvxb0eBep4FsrRFSEdvNIGp7?=
 =?us-ascii?Q?nCvagE3d0+os82IiOGAXrQ9N2A6uvjsYI7I97SNPaevkXi6dXVTFlPoHCZ+Z?=
 =?us-ascii?Q?UEzykSJXTvVjIFwxN9bhIyPl6XbQk9NU1Sdzo3lyd5jI7hTSd7xJGplDfuHD?=
 =?us-ascii?Q?4C7WhcoPZOaE9qmoPfGY8c8pPgDuoae6Hso7leSJ9sezLCP4LE65dnHgqtVg?=
 =?us-ascii?Q?fAtURN/TKSnikFrt8VqBVQo9VcbGUAxIqrXmiXNr48uIsBmBJRtzTZsuHp0A?=
 =?us-ascii?Q?UpeA/I5nQNUy6V8Hz55XVpGKqDuQS2QD0nYz6DJe5oGUyHO9lJzC7ikiGOYw?=
 =?us-ascii?Q?yzKxJ10g4yWkU4bSyKxUx/rro5vT2UXrskiXKjc3/QpoXDboB2f7dkpW46fR?=
 =?us-ascii?Q?6L2TcG60scZVv0lJKRk6Z8Sm1PxGP/d8S7StC+ae2/Zk7G5/WFexaKQ4RkiR?=
 =?us-ascii?Q?HfCkJ4KM2FdM7MzBmBy55BsZSFRfwjsUgG2+YxTw0Dngy0dxufl+UDBK5pCB?=
 =?us-ascii?Q?Ie1yeb1e2f1YNPSFlt8SAt5ENm1AP/QgKhQxdHKotd/PLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?roeq78cwukmgk770uV6g/oOrqWSCLbjpMq/47Qct7ClEBjwxQpH9MmaQ03Sr?=
 =?us-ascii?Q?rU5nYRM9fHk9zgx05Xah9S8+7boXVx9jKzY9LguBfD5qubenJHKSMjUZN7BF?=
 =?us-ascii?Q?WdoJ6b5Lr5Haa+QEreLSbmFyejnrg3JguHr3JCBxJvf0t0Q/xU5D7on73ZaY?=
 =?us-ascii?Q?PEDdceYjiWzV+eV/HolUu68MVyXNuRi88qW16vA95VL+VvK2f5UEmiuxqBzr?=
 =?us-ascii?Q?sd0dwg1aIr7cuNVHOZFCoe8YAqtLVo8dLxBjvEsslgH8roTQjFrAhI+4EwWP?=
 =?us-ascii?Q?PbrpsQe6WOMzg5nPY2W9g8gfQ7HJXzuRCdPgDKOrxX94OvZ+P4/SLTxdQga4?=
 =?us-ascii?Q?Si/rAlTn8E/dsbjzh/0vdIxFkih8W7uVQYv+wAo+MknLRFBYHbB8sAsErGlV?=
 =?us-ascii?Q?jHvGico0gCsfWbLnvKLjvoxmIVxp901YlW4yA+KGKEbI0wYP04eEkA2SX1ij?=
 =?us-ascii?Q?LgABRmDZO/wX4vY2zV3kos4+l3CHrZjIByFoNjxS5J1Bo2UMLF+u8cTgayh3?=
 =?us-ascii?Q?uoUZ5vrdT+QQDexOI6A7t1F1jQyn69pL03O587e6C6sDrhMURJ8nFvbXq4mF?=
 =?us-ascii?Q?8bqbtpaRs9GLetX0IlltKmQ2YaxZngW2JThPxVBylTJeIj3nUwburnT4xkWW?=
 =?us-ascii?Q?/89q5MLpKZL7I38BWedjP0XzWHnHcxmJgmSVHJLP7AZ5V6YKS0AITjvpW47A?=
 =?us-ascii?Q?2onzHaUs8ghlYBOiA1HKD5buxdR+JjU/xzj3N/w0vet8l0Fmgjub1ddMWyvt?=
 =?us-ascii?Q?qIIuO4CKPu32mpkiPKkmkIY0L49bZ+7RclOIMW8yXTeIr2TUWVU0A9MHIwlX?=
 =?us-ascii?Q?6+Fo9B7NjGkEJIAPywUxIgBjqX0Vs0mjtV1pP3DpOA+apsmLQzaqy7M2oeI5?=
 =?us-ascii?Q?1wBKbP1C6JTt6GXkNp2HG5lL1vwhP9ec+wJCcx/P2VmcUtI4u8cYOCaL2gqx?=
 =?us-ascii?Q?HBB36fiK7Jwaab9SNtToFk64MJ32U3rCV281+hkSaspjRVcyGiu421viKCgG?=
 =?us-ascii?Q?qLWqoVZlno9iH56LIEYaPsy/vNJV981kWJZTOnV9DPU57n0x3suYvFGpuU52?=
 =?us-ascii?Q?VLQvu4BxRdK6bXbZxE27frcXnISXe8d39EUSRIHL55hveZFSVOx74tJPrhgr?=
 =?us-ascii?Q?xl8TLQpB1KSK25wpIYrPbh+J1hBEKeGkTZnA5m8XL1F93tquZP9ZJo+ruB94?=
 =?us-ascii?Q?3/igoT+s+PFaeL3gB2vGAj4HlwZc5a0r1Xrn+Fu2v//STnVne/abP+hEmsXZ?=
 =?us-ascii?Q?6jlt1cviYhz6VIjvIUUHozy/NQe7Z3rJ+lh+UDa6QihJWJjsxccTJ1QHxZiU?=
 =?us-ascii?Q?hG0rEdOewYXzsL6aXQV4pfOvgd1clynRPzo+nk7G5P8eczhoRKRmtiKLOcwv?=
 =?us-ascii?Q?VLMLGFXj+O3/MMc+aUlKnXPOJqL7PxwfOP2P1uWKK7/QBVVHy5c7Oqtj9yMT?=
 =?us-ascii?Q?iAdf/V1kHTfmRvYpEAw9Mpf0oo7cHzlqpvjFfcjcvJih/omgs+eSbiEjrvSO?=
 =?us-ascii?Q?2wTHubJ8yiX7HpQtJf7oAV6FcbJRsgZiU9uJtBf3gLM1XslxWL3zktTXvbvg?=
 =?us-ascii?Q?ZVXIFMZ3rJpyG4z3gghwgWpJpV5+XYVcOvfYiGBl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QkbOn45fwIAeTRnZNly5uwk9Jwbu40UhL3K8pUcuVBFM7mKUYh3yGwcXgImgTy9vv0CFLNB+PfchjlJwyDglrnUeQa7Z+rbxx8J6aDrlwevCcfAVOp8SO0iIl7iqPgs42J8N3JmfKgBdsjOeapUqo6+p1trggFsqnAYG/ywdy/88TxLqvG/eZbIFl3Vb0fDmsjGqP5C8xQrLrr81oSGCrCs+qV0cQP3CsgwPpHG1nf4Zp8RrUjOoJKJsdR5g1ri2nzbBVVT6TxgcqOR88Y0X9qurb0fuOGNe2Utx4FL17YhTeRdnUpIJ9XqSXUJYB+2OkUTskUjxN7C9Y1+4y9sL4IxPxxUyZTv+5CnHmRlPqOrxS2V9g17JaVUXSwKvb5CFeYlHFHQHQ1ag0TeHtTuHzpcX0CuVP3+r7u9JovtJYZXnCXCM2OUWDCS0ZnT5JCgyYgRzpirJVI11J/3ns/9B7Oa0AUHpGSiDXEPt8EFXlSzIaDqyJWpNJ6WuiVaU1In2jIGyTDTYv7xmln00DVXIxXljNFNjaEOLHfEQrxmIAbaOh6ws+d5IEgEZcEM+P/oiu21/QLXlQIs7kUYSNJwWtMQvvydLm7f7mufSpEUX8+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cf09d5-08da-41d9-bf62-08dcd89cc989
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 11:18:28.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liZjkMo3PQJrX5qXBu+3xTQLnRIRnHcuXCHPXGX1G9v560enVRhN7N8ldAi44kH81vToQSRS9j8F4/A7WH6E1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_08,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409190073
X-Proofpoint-GUID: 9rMCWXRSARQtJgjEvvRuwztBWPz8Hp1L
X-Proofpoint-ORIG-GUID: 9rMCWXRSARQtJgjEvvRuwztBWPz8Hp1L

* Mike Rapoport <rppt@kernel.org> [240909 02:49]:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
> 
> Extend execmem_alloc() with an ability to use huge pages with ROX
> permissions as a cache for smaller allocations.
> 
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
> 
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
> 
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
> 
> The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
> definition of an execmem_range.

I am not sure you need to convert to xa entries.

> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/execmem.h |   2 +
>  mm/execmem.c            | 289 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 286 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index dfdf19f8a5e8..7436aa547818 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -77,12 +77,14 @@ struct execmem_range {
>  
>  /**
>   * struct execmem_info - architecture parameters for code allocations
> + * @fill_trapping_insns: set memory to contain instructions that will trap
>   * @ranges: array of parameter sets defining architecture specific
>   * parameters for executable memory allocations. The ranges that are not
>   * explicitly initialized by an architecture use parameters defined for
>   * @EXECMEM_DEFAULT.
>   */
>  struct execmem_info {
> +	void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
>  	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
>  };
>  
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 0f6691e9ffe6..f547c1f3c93d 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -7,28 +7,88 @@
>   */
>  
>  #include <linux/mm.h>
> +#include <linux/mutex.h>
>  #include <linux/vmalloc.h>
>  #include <linux/execmem.h>
> +#include <linux/maple_tree.h>
>  #include <linux/moduleloader.h>
>  #include <linux/text-patching.h>
>  
> +#include <asm/tlbflush.h>
> +
> +#include "internal.h"
> +
>  static struct execmem_info *execmem_info __ro_after_init;
>  static struct execmem_info default_execmem_info __ro_after_init;
>  
> -static void *__execmem_alloc(struct execmem_range *range, size_t size)
> +#ifdef CONFIG_MMU
> +struct execmem_cache {
> +	struct mutex mutex;
> +	struct maple_tree busy_areas;
> +	struct maple_tree free_areas;
> +};
> +
> +static struct execmem_cache execmem_cache = {
> +	.mutex = __MUTEX_INITIALIZER(execmem_cache.mutex),
> +	.busy_areas = MTREE_INIT_EXT(busy_areas, MT_FLAGS_LOCK_EXTERN,
> +				     execmem_cache.mutex),
> +	.free_areas = MTREE_INIT_EXT(free_areas, MT_FLAGS_LOCK_EXTERN,
> +				     execmem_cache.mutex),
> +};
> +
> +static void execmem_cache_clean(struct work_struct *work)
> +{
> +	struct maple_tree *free_areas = &execmem_cache.free_areas;
> +	struct mutex *mutex = &execmem_cache.mutex;
> +	MA_STATE(mas, free_areas, 0, ULONG_MAX);
> +	void *area;
> +
> +	mutex_lock(mutex);
> +	mas_for_each(&mas, area, ULONG_MAX) {
> +		size_t size;
> +
> +		if (!xa_is_value(area))
> +			continue;
> +
> +		size = xa_to_value(area);
> +
> +		if (IS_ALIGNED(size, PMD_SIZE) &&
> +		    IS_ALIGNED(mas.index, PMD_SIZE)) {
> +			void *ptr = (void *)mas.index;

If you store this pointer then it would be much nicer.

> +
> +			mas_erase(&mas);

mas_store_gfp() would probably be better here to store a null.

> +			vfree(ptr);
> +		}
> +	}
> +	mutex_unlock(mutex);
> +}
> +
> +static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
> +
> +static void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable)
> +{
> +	if (execmem_info->fill_trapping_insns)
> +		execmem_info->fill_trapping_insns(ptr, size, writable);
> +	else
> +		memset(ptr, 0, size);
> +}
> +
> +static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> +			     pgprot_t pgprot, unsigned long vm_flags)
>  {
>  	bool kasan = range->flags & EXECMEM_KASAN_SHADOW;
> -	unsigned long vm_flags  = VM_FLUSH_RESET_PERMS;
>  	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOWARN;
> +	unsigned int align = range->alignment;
>  	unsigned long start = range->start;
>  	unsigned long end = range->end;
> -	unsigned int align = range->alignment;
> -	pgprot_t pgprot = range->pgprot;
>  	void *p;
>  
>  	if (kasan)
>  		vm_flags |= VM_DEFER_KMEMLEAK;
>  
> +	if (vm_flags & VM_ALLOW_HUGE_VMAP)
> +		align = PMD_SIZE;
> +
>  	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
>  				 pgprot, vm_flags, NUMA_NO_NODE,
>  				 __builtin_return_address(0));
> @@ -50,8 +110,225 @@ static void *__execmem_alloc(struct execmem_range *range, size_t size)
>  		return NULL;
>  	}
>  
> +	return p;
> +}
> +
> +static int execmem_cache_add(void *ptr, size_t size)
> +{
> +	struct maple_tree *free_areas = &execmem_cache.free_areas;
> +	struct mutex *mutex = &execmem_cache.mutex;
> +	unsigned long addr = (unsigned long)ptr;
> +	MA_STATE(mas, free_areas, addr - 1, addr + 1);
> +	unsigned long lower, lower_size = 0;
> +	unsigned long upper, upper_size = 0;
> +	unsigned long area_size;
> +	void *area = NULL;
> +	int err;
> +
> +	lower = addr;
> +	upper = addr + size - 1;
> +
> +	mutex_lock(mutex);
> +	area = mas_walk(&mas);
> +	if (area && xa_is_value(area) && mas.last == addr - 1) {
> +		lower = mas.index;
> +		lower_size = xa_to_value(area);
> +	}
> +
> +	area = mas_next(&mas, ULONG_MAX);
> +	if (area && xa_is_value(area) && mas.index == addr + size) {
> +		upper = mas.last;
> +		upper_size = xa_to_value(area);
> +	}
> +
> +	mas_set_range(&mas, lower, upper);
> +	area_size = lower_size + upper_size + size;
> +	err = mas_store_gfp(&mas, xa_mk_value(area_size), GFP_KERNEL);
> +	mutex_unlock(mutex);
> +	if (err)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static bool within_range(struct execmem_range *range, struct ma_state *mas,
> +			 size_t size)
> +{
> +	unsigned long addr = mas->index;
> +
> +	if (addr >= range->start && addr + size < range->end)
> +		return true;
> +
> +	if (range->fallback_start &&
> +	    addr >= range->fallback_start && addr + size < range->fallback_end)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
> +{
> +	struct maple_tree *free_areas = &execmem_cache.free_areas;
> +	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> +	MA_STATE(mas_free, free_areas, 0, ULONG_MAX);
> +	MA_STATE(mas_busy, busy_areas, 0, ULONG_MAX);
> +	struct mutex *mutex = &execmem_cache.mutex;
> +	unsigned long addr, last, area_size = 0;
> +	void *area, *ptr = NULL;
> +	int err;
> +
> +	mutex_lock(mutex);
> +	mas_for_each(&mas_free, area, ULONG_MAX) {
> +		area_size = xa_to_value(area);
> +
> +		if (area_size >= size && within_range(range, &mas_free, size))
> +			break;
> +	}
> +
> +	if (area_size < size)
> +		goto out_unlock;
> +
> +	addr = mas_free.index;
> +	last = mas_free.last;
> +
> +	/* insert allocated size to busy_areas at range [addr, addr + size) */
> +	mas_set_range(&mas_busy, addr, addr + size - 1);
> +	err = mas_store_gfp(&mas_busy, xa_mk_value(size), GFP_KERNEL);
> +	if (err)
> +		goto out_unlock;
> +
> +	mas_erase(&mas_free);
> +	if (area_size > size) {
> +		/*
> +		 * re-insert remaining free size to free_areas at range
> +		 * [addr + size, last]
> +		 */
> +		mas_set_range(&mas_free, addr + size, last);
> +		size = area_size - size;
> +		err = mas_store_gfp(&mas_free, xa_mk_value(size), GFP_KERNEL);
> +		if (err) {
> +			mas_erase(&mas_busy);
> +			goto out_unlock;
> +		}
> +	}

It would be more efficient to replace the entry then erase the portion.

Something like
	if (area_size > size) {
		err = mas_store_gfp(&mas_free, xa_mk_value(size), GFP_KERNEL);
		if (err)
		...
		/* range mismatches stored size here */
	}
	mas_set_range(&mas_busy, addr, addr + size - 1);
	mas_store_gfp(&mas_free, NULL, GFP_KERNEL);


> +	ptr = (void *)addr;
> +
> +out_unlock:
> +	mutex_unlock(mutex);
> +	return ptr;
> +}
> +
> +static int execmem_cache_populate(struct execmem_range *range, size_t size)
> +{
> +	unsigned long vm_flags = VM_FLUSH_RESET_PERMS | VM_ALLOW_HUGE_VMAP;
> +	unsigned long start, end;
> +	struct vm_struct *vm;
> +	size_t alloc_size;
> +	int err = -ENOMEM;
> +	void *p;
> +
> +	alloc_size = round_up(size, PMD_SIZE);
> +	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> +	if (!p)
> +		return err;
> +
> +	vm = find_vm_area(p);
> +	if (!vm)
> +		goto err_free_mem;
> +
> +	/* fill memory with instructions that will trap */
> +	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
> +
> +	start = (unsigned long)p;
> +	end = start + alloc_size;
> +
> +	vunmap_range(start, end);
> +
> +	err = vmap_pages_range_noflush(start, end, range->pgprot, vm->pages,
> +				       PMD_SHIFT);
> +	if (err)
> +		goto err_free_mem;
> +
> +	err = execmem_cache_add(p, alloc_size);
> +	if (err)
> +		goto err_free_mem;
> +
> +	return 0;
> +
> +err_free_mem:
> +	vfree(p);
> +	return err;
> +}
> +
> +static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
> +{
> +	void *p;
> +	int err;
> +
> +	p = __execmem_cache_alloc(range, size);
> +	if (p)
> +		return p;
> +
> +	err = execmem_cache_populate(range, size);
> +	if (err)
> +		return NULL;
> +
> +	return __execmem_cache_alloc(range, size);
> +}
> +
> +static bool execmem_cache_free(void *ptr)
> +{
> +	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> +	struct mutex *mutex = &execmem_cache.mutex;
> +	unsigned long addr = (unsigned long)ptr;
> +	MA_STATE(mas, busy_areas, addr, addr);
> +	size_t size;
> +	void *area;
> +
> +	mutex_lock(mutex);
> +	area = mas_walk(&mas);
> +	if (!area) {
> +		mutex_unlock(mutex);
> +		return false;
> +	}
> +	size = xa_to_value(area);
> +	mas_erase(&mas);

Again, it is probably better to store null.  erase is more of if you are
unsure on where the index range ends, and since the maple state is
already set up to erase, it's best to just store NULL.

> +	mutex_unlock(mutex);
> +
> +	execmem_fill_trapping_insns(ptr, size, /* writable = */ false);
> +
> +	execmem_cache_add(ptr, size);
> +
> +	schedule_work(&execmem_cache_clean_work);
> +
> +	return true;
> +}
> +
> +static void *__execmem_alloc(struct execmem_range *range, size_t size)
> +{
> +	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
> +	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> +	pgprot_t pgprot = range->pgprot;
> +	void *p;
> +
> +	if (use_cache)
> +		p = execmem_cache_alloc(range, size);
> +	else
> +		p = execmem_vmalloc(range, size, pgprot, vm_flags);
> +
>  	return kasan_reset_tag(p);
>  }
> +#else
> +static void *__execmem_alloc(struct execmem_range *range, size_t size)
> +{
> +	return vmalloc(size);
> +}
> +
> +static bool execmem_cache_free(void *ptr)
> +{
> +	return false;
> +}
> +#endif
>  
>  void *execmem_alloc(enum execmem_type type, size_t size)
>  {
> @@ -67,7 +344,9 @@ void execmem_free(void *ptr)
>  	 * supported by vmalloc.
>  	 */
>  	WARN_ON(in_interrupt());
> -	vfree(ptr);
> +
> +	if (!execmem_cache_free(ptr))
> +		vfree(ptr);
>  }
>  
>  void *execmem_update_copy(void *dst, const void *src, size_t size)
> -- 
> 2.43.0
> 

